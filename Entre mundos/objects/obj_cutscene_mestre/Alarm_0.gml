timer_cena += 1;

switch(timer_cena) {
    case 1:
        // O player olha para cima ou faz algo
        if (instance_exists(obj_player)) obj_player.sprite_index = spr_player_olhando_tras;
        alarm[0] = 90; // Próximo passo em 1.5 segundos
        break;

    case 2:
        // Aparece um texto na tela (usando seu sistema de aviso)
        if (instance_exists(obj_controlador)) {
            obj_controlador.aviso_texto = "O que foi esse barulho no elevador?";
            obj_controlador.aviso_timer = 120;
        }
        alarm[0] = 150;
        break;

    case 3:
        // A tela treme (Screenshake)
        // view_set_xport(0, irandom_range(-5, 5)); // Exemplo simples
        alarm[0] = 60;
        break;

    case 4:
        // Fim da cutscene
        global.cutscene = false;
        instance_destroy(); // O diretor vai embora
        break;
}