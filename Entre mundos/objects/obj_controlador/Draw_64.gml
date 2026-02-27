if (!instance_exists(obj_player)) exit;

var _x = 37;  
var _y = 28; 

// --- 1. DESENHA A VIDA (Corte da barra verde) ---
var _vida_atual = clamp(obj_player.vida, 0, obj_player.vida_max);
var _hp_porcentagem = _vida_atual / obj_player.vida_max;
var _w = sprite_get_width(spr_hud_vida);
var _h = sprite_get_height(spr_hud_vida);
var _altura_para_desenhar = _h * _hp_porcentagem;
var _onde_comecar_o_corte = _h - _altura_para_desenhar;

draw_sprite_part(
    spr_hud_vida, 0, 
    0, _onde_comecar_o_corte,           
    _w, _altura_para_desenhar,        
    _x - (_w / 2),            
    _y - (_h / 2) + _onde_comecar_o_corte
);

// --- 2. DESENHA A BASE DA HUD ---
draw_sprite(spr_hud_base, 0, _x, _y);

// --- 3. DESENHA OS ÍCONES SE TIVER A ARMA (mao_atual == 1) ---
if (obj_player.mao_atual == 1) 
{
    // Desenha a arma (ajuste os valores -15 e -5 para bater com sua sprite)
    draw_sprite(spr_hud_arma, 0, _x, _y );
    
    // Desenha o ícone de munição (em cima da vida ou perto do número)
    draw_sprite(spr_item_municao, 0, _x - 13, _y + 5);
}

// --- 4. DESENHA O NÚMERO DE MUNIÇÃO ---
draw_set_halign(fa_center); 
draw_set_valign(fa_middle); 
draw_set_font(fnt_hud);     

var _municao_texto = string(obj_player.municao);
var _txt_x = _x + 5; // Posição que definimos antes
var _txt_y = _y + 3;

// Sombra e Texto
draw_set_color(c_black);
draw_text(_txt_x + 1, _txt_y + 1, _municao_texto); 
draw_set_color(c_white);
draw_text(_txt_x, _txt_y, _municao_texto); 

// Resetar
draw_set_halign(fa_left);
draw_set_valign(fa_top);


// --- EXIBIR CARTÃO NA HUD (LADO DIREITO SUPERIOR) ---
if (obj_player.tem_cartao) 
{
    var _cx = 290; // Posição X que você pediu
    var _cy = 18;  // Posição Y que você pediu
    
    // 1. Desenha a Sprite do Cartão
    // O 'subimg' 0 é o primeiro frame. 
    // Se a sprite estiver centralizada, o texto deve ser deslocado um pouco.
    draw_sprite_ext(spr_hud_cartao, 0, _cx, _cy, 1, 1, 0, c_white, 1);
    
    // 2. Configura o Texto
    draw_set_font(fnt_itens);
    draw_set_halign(fa_left);   // Alinha o texto à esquerda do ponto inicial
    draw_set_valign(fa_middle); // Alinha o texto pelo meio da altura
    
    // 3. Desenha o Nome "Cartão Verde" ao lado da sprite
    // Somamos +20 no X para o texto não ficar em cima do desenho
    draw_set_color(c_black);
    draw_text(_cx - 21, _cy + 17, "KayCard"); // Sombra
    
    draw_set_color(c_white); 
    draw_text(_cx - 20, _cy + 16, "KayCard"); // Texto principal
}



// Certifique-se de que o player existe
if (instance_exists(obj_player)) {
    
    // --- 1. RESET DE ESTILO (Isso impede que o texto mude de tamanho ou lugar) ---
    draw_set_font(fnt_hud);      // Certifique-se de ter criado essa fonte (Passo anterior)
    draw_set_halign(fa_left);    // Alinha o texto à esquerda
    draw_set_valign(fa_top);     // Alinha o texto pelo topo
    
    // --- 2. LÓGICA DE TRANSPARÊNCIA ---
    // Ajustei para 5, que é o seu HP máximo que definimos antes
    var _alpha_hud = (obj_player.vida < 5) ? 1 : 0.3;
    
    // --- 3. COORDENADAS FIXAS ---
    var _posX = 13;
    var _posY = 45;

    // Desenha o Ícone
    draw_sprite_ext(spr_medkit, 0, _posX, _posY, 1, 1, 0, c_white, _alpha_hud);
    
    // Desenha o Texto (Ajustado para ficar ao lado do ícone: _posX + 15)
    // Se o texto estiver muito alto ou baixo, mude o _posY + 2
    draw_text_color(_posX + 8, _posY - 6, "x" + string(obj_player.medkits), c_white, c_white, c_white, c_white, _alpha_hud);
	
	
	if (instance_exists(obj_porta_elevador)) {
        var _p = obj_porta_elevador;
        
        // Se a porta começou a abrir
        if (_p.sprite_index == spr_porta_abrindo) {
            
            // O fade_alpha sobe bem devagar
            // 0.005 fará o ecrã levar cerca de 3 a 4 segundos para ficar todo preto
            if (fade_alpha < 1) {
                fade_alpha += 0.0007; 
            }
            
            // Desenha o retângulo preto
            draw_set_alpha(fade_alpha);
            draw_set_color(c_black);
            draw_rectangle(0, 0, display_get_gui_width(), display_get_gui_height(), false);
            
            // RESET (Obrigatório)
            draw_set_alpha(1);
            draw_set_color(c_white);
        }
		
		// --- MENSAGEM DE ACESSO AUTORIZADO ---
// 1. Verificamos se a porta existe na fase
if (instance_exists(obj_porta_elevador)) 
{
    // Criamos uma variável curta '_p' para facilitar a escrita
    var _p = obj_porta_elevador; 

    // 2. Só desenha se a porta estiver aberta E ainda estiver no início da animação (frames 0 a 10)
    // Aumentei para 10 para dar tempo do player ler a mensagem!
    if (_p.aberta && _p.image_index < 10) 
    {
        // --- CONFIGURAÇÃO DO TEXTO (Importante para iniciantes!) ---
        draw_set_font(fnt_hud);       // Define a sua fonte
        draw_set_halign(fa_center);   // Centraliza o texto horizontalmente
        draw_set_valign(fa_middle);   // Centraliza o texto verticalmente
        
        var _gx = display_get_gui_width() / 2;  // Meio da tela (X)
        var _gy = display_get_gui_height() - 40; // Perto do rodapé (Y)

        // 3. DESENHA UMA SOMBRA (Para o texto não sumir no cenário claro)
        draw_set_color(c_black);
        draw_text(_gx + 2, _gy + 2, "ACESSO AUTORIZADO");

        // 4. DESENHA O TEXTO PRINCIPAL EM VERDE LIMA
        draw_set_color(c_lime);
        draw_text(_gx, _gy, "ACESSO AUTORIZADO");

        // --- RESETAR CONFIGURAÇÕES ---
        // Isso é OBRIGATÓRIO para não estragar os outros desenhos do jogo
        draw_set_color(c_white);
        draw_set_halign(fa_left); // Volta o alinhamento para a esquerda
        draw_set_valign(fa_top);  // Volta o alinhamento para o topo
    }
    }
    }
}











// Reseta as cores para o padrão
draw_set_color(c_white);
draw_set_halign(fa_left);
draw_set_valign(fa_top);






