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
    draw_sprite(spr_hud_municao, 0, _x, _y);
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
if (obj_player.tem_cartao) {
    var _cx = 290; // Posição X que você pediu
    var _cy = 30;  // Posição Y que você pediu
    
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

// Reseta as cores para o padrão
draw_set_color(c_white);
draw_set_halign(fa_left);
draw_set_valign(fa_top);

