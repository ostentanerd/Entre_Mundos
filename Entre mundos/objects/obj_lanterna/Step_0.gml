// 1. Seguir o Player (Mantendo seu código original)
if (instance_exists(obj_player)) {
    x = lerp(x, obj_player.x, 0.4); 
    y = lerp(y, obj_player.y - 11, 0.4);
    image_xscale = obj_player.face;
}

// 2. Lógica de Gasto e Recarga
if (global.luz_acesa) {
    // Se está ligada, consome bateria
    carga_atual -= taxa_gasto;
    
    // Se a bateria acabar, desliga sozinha
    if (carga_atual <= 0) {
        carga_atual = 0;
        global.luz_acesa = false;
        sprite_index = spr_lanterna_apagada;
        tempo_bloqueio = true; // Bloqueia para recarregar um pouco antes de usar de novo
    }
} else {
    // Se está desligada, recarrega até o máximo
    if (carga_atual < carga_maxima) {
        carga_atual += taxa_recarga;
    }
    
    // Se já recarregou pelo menos 20%, permite ligar de novo
    if (carga_atual > 20) {
        tempo_bloqueio = false;
    }
}

// 3. Lógica do Botão "L" (Ajustada)
if (keyboard_check_pressed(ord("L"))) {
    // Só deixa ligar se tiver carga e não estiver no "bloqueio" de bateria vazia
    if (!global.luz_acesa && carga_atual > 0 && !tempo_bloqueio) {
        global.luz_acesa = true;
        sprite_index = spr_lanterna_acesa;
     //   audio_play_sound(snd_click, 1, false); // Opcional: som de click
    } else {
        global.luz_acesa = false;
        sprite_index = spr_lanterna_apagada;
    }
}