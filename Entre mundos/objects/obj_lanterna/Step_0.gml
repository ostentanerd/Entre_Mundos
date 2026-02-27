// 1. Seguir o Player com suavidade
if (instance_exists(obj_player)) {
    // Em vez de '=', usamos o lerp para ela "deslizar" até a posição
    x = lerp(x, obj_player.x, 0.4); 
    y = lerp(y, obj_player.y - 11, 0.4);
    
    image_xscale = obj_player.face;
}

// 2. Lógica de ligar/desligar com som
// No Step do obj_lanterna_apagada
if (keyboard_check_pressed(ord("L"))) {
    if (global.luz_acesa == false) {
        global.luz_acesa = true;
        sprite_index = spr_lanterna_acesa;
        show_debug_message("LIGOU");
    } else {
        global.luz_acesa = false;
        sprite_index = spr_lanterna_apagada;
        show_debug_message("DESLIGOU");
    }
}



// Isso vai mostrar no topo da tela se o jogo acha que está acesa ou não
window_set_caption("Sprite: " + sprite_get_name(sprite_index));