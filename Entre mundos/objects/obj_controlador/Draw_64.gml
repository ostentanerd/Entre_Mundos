// Pega o tamanho real da janela para o texto ficar nítido
var _largura = window_get_width();
var _altura = window_get_height();
display_set_gui_size(_largura, _altura);

// --- INÍCIO DA ESCALA DA HUD ---
// Isso "dá um zoom" em tudo que vem abaixo
var _m = matrix_build(0, 0, 0, 0, 0, 0, global.hud_escala, global.hud_escala, 1);
matrix_set(matrix_world, _m);



if (!instance_exists(obj_player)) exit;

var _x = 37;  
var _y = 28; 

// --- 1. DESENHA A VIDA (Corte da barra verde) ---
var _vida_atual = clamp(global.vida, 0, obj_player.vida_max);
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

var _municao_texto = string(global.municao);
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


// --- EXIBIR CARTÃO NA HUD (LADO DIREITO SUPERIOR DINÂMICO) ---
if (global.tem_cartao) 
{
    // Calculamos a largura da GUI dividida pela escala para saber onde é a "ponta direita"
    var _gui_w = display_get_gui_width() / global.hud_escala;
    
    // Posição X: Largura Total - 50 pixels de margem
    var _cx = _gui_w - 50; 
    var _cy = 18;  // Mantemos o Y no topo
    
    // 1. Desenha a Sprite do Cartão
    draw_sprite_ext(spr_hud_cartao, 0, _cx, _cy, 1, 1, 0, c_white, 1);
    
    // 2. Configura o Texto
    draw_set_font(fnt_itens);
    draw_set_halign(fa_right);  // Mudamos para RIGHT para o texto crescer para a ESQUERDA da posição
    draw_set_valign(fa_middle); 
    
    // 3. Desenha o Nome "KayCard" (Ajustado para o novo X)
    // Usamos _cx - 10 para o texto ficar logo atrás do ícone do cartão
    draw_set_color(c_black);
    draw_text(_cx - 9, _cy + 1, "KayCard"); // Sombra
    
    draw_set_color(c_white); 
    draw_text(_cx - 10, _cy, "KayCard"); // Texto principal
}


// Certifique-se de que o player existe
if (instance_exists(obj_player)) 
{
    
    // --- 1. RESET DE ESTILO (Isso impede que o texto mude de tamanho ou lugar) ---
    draw_set_font(fnt_hud);      // Certifique-se de ter criado essa fonte (Passo anterior)
    draw_set_halign(fa_left);    // Alinha o texto à esquerda
    draw_set_valign(fa_top);     // Alinha o texto pelo topo
    
    // --- 2. LÓGICA DE TRANSPARÊNCIA ---
    // Ajustei para 5, que é o seu HP máximo que definimos antes
    var _alpha_hud = (global.vida < 5) ? 1 : 0.3;
    
    // --- 3. COORDENADAS FIXAS ---
    var _posX = 13;
    var _posY = 45;

    // Desenha o Ícone
    draw_sprite_ext(spr_medkit, 0, _posX, _posY, 1, 1, 0, c_white, _alpha_hud);
    
    // Desenha o Texto (Ajustado para ficar ao lado do ícone: _posX + 15)
    // Se o texto estiver muito alto ou baixo, mude o _posY + 2
    draw_text_color(_posX + 8, _posY - 6, "x" + string(global.medkits), c_white, c_white, c_white, c_white, _alpha_hud);
	
	
	
}

if (aviso_timer > 0) {
    draw_set_font(fnt_itens); // Usa a fonte que você já criou
    draw_set_halign(fa_center);
    
    var _x_centro = display_get_gui_width() / 2;
    var _y_mensagem =150; // Altura da mensagem na tela

    // Desenha uma sombra preta primeiro (para destacar)
    draw_set_color(c_dkgray);
    draw_text(_x_centro + 2, _y_mensagem -20, "Precida do KayCard");

    // Desenha o texto principal em Vermelho ou Amarelo
    draw_set_color(c_white); 
    draw_text(_x_centro + 2, _y_mensagem -20, "Precida do KayCard");
    
    // SEMPRE RESETAR A COR
    draw_set_color(c_white);
    draw_set_halign(fa_left);
}

if (texto_titulo_timer > 0) {
    draw_set_font(fnt_missao); 
    draw_set_halign(fa_center);
    
    // Efeito de transparência para o texto sumir suavemente no final
    var _alpha = 1;
    if (texto_titulo_timer < 60) {
        _alpha = texto_titulo_timer / 60; // Faz o fade-out no último segundo
    }
    
    draw_set_alpha(_alpha);
    draw_set_color(c_white);
    draw_text(display_get_gui_width() / 2, 20, "TERRA-2149: ZUMBI");
	
    
    // Sempre resete o alpha e a cor para não bugar o resto da HUD
    draw_set_alpha(1);
    draw_set_color(c_white);
}


var _largura = window_get_width();
var _altura = window_get_height();
display_set_gui_size(_largura, _altura);





// Reseta as cores para o padrão
draw_set_color(c_white);
draw_set_halign(fa_left);
draw_set_valign(fa_top);















// --- FIM DA ESCALA DA HUD ---
// Reseta a escala para não afetar outras coisas (como o mouse ou filtros)
matrix_set(matrix_world, matrix_build_identity());