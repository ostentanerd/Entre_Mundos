/// --- INPUTS ---
// Adicionamos a checagem da global.pode_mover aqui nos inputs
var _pode = global.pode_mover; 

var _key_left      = _pode && (keyboard_check(ord("A"))  ||  keyboard_check(vk_left));
var _key_right     = _pode && (keyboard_check(ord("D"))  ||  keyboard_check(vk_right));
var _key_up        = _pode && (keyboard_check(ord("W"))  ||  keyboard_check(vk_up));
var _key_down      = _pode && (keyboard_check(ord("S"))  ||  keyboard_check(vk_down));
var _key_jump      = _pode && keyboard_check_pressed(ord("J"));
var _key_interact  = _pode && keyboard_check_pressed(ord("E"));
var _key_flashlight = _pode && keyboard_check_pressed(ord("L"));
var _key_heal      = _pode && keyboard_check_pressed(ord("U"));


if (global.cutscene == true) {
    hvel = 0; // Trava o movimento horizontal
    vvel = 0; // Trava o movimento vertical
    
    // Deixamos a image_speed quieta para a animação continuar rodando
    // Se você usa uma sprite específica de parado, pode garantir ela aqui:
    if (sprite_index != spr_player_idle) {
        sprite_index = spr_player_idle;
    }
    
    exit; // Para o código aqui, impedindo que os comandos de teclado funcionem
}


// 1. CHECAGEM DE MORTE
if (global.vida <= 0) {
    if (sprite_index != spr_player_morto) { 
        sprite_index = spr_player_morto;
        image_index = 0;
        image_speed = 1;
        
        layer_set_visible("Restart", true);
        layer_set_visible("Preto", true);
        
        if (instance_exists(meus_bracos)) instance_destroy(meus_bracos);
        if (instance_exists(global.meu_lanterna)) instance_destroy(global.meu_lanterna);
        
        alarm[2] = 150;
        mask_index = -1; 
        exit;
    }
    
    if (image_index >= image_number - 1) image_speed = 0;
    
    // Gravidade para o corpo morto
    if (!place_meeting(x, y + 1, obj_chao_normal)) {
        vsp += 0.3;
        if (place_meeting(x, y + vsp, obj_chao_normal)) {
            while (!place_meeting(x, y + sign(vsp), obj_chao_normal)) y += sign(vsp);
            vsp = 0;
        }
        y += vsp;
    }
    exit; 
}

// --- TRAVA DE MOVIMENTO (Caso global.pode_mover seja falso) ---
if (!global.pode_mover) {
    hsp = 0;
    vsp += 0.3; // Mantém gravidade para não flutuar
    sprite_index = spr_player_idle;
    // O código de colisão abaixo ainda vai rodar para ele não cair pelo chão
}

if (brilho_tiro > 0) brilho_tiro -= 0.15; 

//  ---- LÓGICA DA ESCADAS ----
if (place_meeting(x, y, obj_escada)) {
    if (_key_up || _key_down) no_escada = true;
} else {
    no_escada = false;
}

if (no_escada) {
    vsp = (_key_down - _key_up) * vel_escada;
    hsp = 0;
    grv = 0;
} else {
    grv = 0.3;
    var _move = _key_right - _key_left;
    hsp = _move * walksp;
    vsp += grv;
    if (_move != 0) face = _move;
    
    if (place_meeting(x, y + 1, obj_chao_normal) && _key_jump) vsp = -jumpsp;
}

//  --- COLISÕES ---
if (place_meeting(x + hsp, y, obj_chao_normal)) {
    while (!place_meeting(x + sign(hsp), y, obj_chao_normal)) x += sign(hsp);
    hsp = 0;
}
x += hsp;

if (place_meeting(x, y + vsp, obj_chao_normal)) {
    while (!place_meeting(x, y + sign(vsp), obj_chao_normal)) y += sign(vsp);
    vsp = 0;
}
y += vsp;

// ---- INTERAGIR (PEGAR ITENS) ----
if (_key_interact) {
    var _item = instance_place(x, y, obj_item_pai);
    if (_item != noone) {
        if (_item.tipo == "arma") {
            global.tem_pistola = true; 
            mao_atual = 1;
            global.municao += 10;
        }
        else if (_item.tipo == "municao") {
            global.municao += _item.quantidade;
        }
        else if (_item.tipo == "cartao") {
            global.tem_cartao = true; 
        }
        else if (_item.tipo == "medkits") {
            global.medkits += 1; 
        }
        instance_destroy(_item);
    }
}

// --- ATUALIZAR ANIMAÇÕES ---
image_xscale = face; 
if (place_meeting(x, y + 1, obj_chao_normal)) {
    if (hsp != 0) sprite_index = spr_player_andando;
    else sprite_index = spr_player_idle;
}

// --- BRAÇOS E MÃOS ---
if (instance_exists(meus_bracos)) {
    meus_bracos.x = x;
    meus_bracos.y = y;
    meus_bracos.image_xscale = face;
    
    var _animando = (meus_bracos.sprite_index == spr_mao_pistola_atirando || meus_bracos.sprite_index == spr_mao_facada);
    if (!_animando) {
        switch (mao_atual) {
            case 0: meus_bracos.sprite_index = spr_mao; break;
            case 1: 
                if (global.tem_pistola) meus_bracos.sprite_index = spr_mao_pistola;
                else meus_bracos.sprite_index = spr_mao; 
            break;
        }
    }
}




if (window_has_focus()) {
    var _w = window_get_width();
    var _h = window_get_height();
    if (display_get_gui_width() != _w || display_get_gui_height() != _h) {
        display_set_gui_size(_w, _h);
    }
}

// --- LANTERNA ---


// --- INVULNERABILIDADE ---
if (!pode_tomar_dano) {
    image_alpha = sin(current_time * 0.1); 
} else {
    image_alpha = 1;
}

// --- CURA ---
if (_key_heal) {
    if (global.medkits > 0 && global.vida < 5) {
        global.medkits -= 1;
        var _cura = irandom_range(2, 5);
        global.vida += _cura;
        if (global.vida > 5) global.vida = 5; 
    }
}