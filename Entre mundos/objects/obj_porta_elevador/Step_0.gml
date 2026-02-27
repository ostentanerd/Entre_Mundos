// 1. Checar se o player existe para não dar erro de jogo fechando
if (instance_exists(obj_player)) 
{
    // 2. Medir a distância entre a porta e o player
    var _distancia = distance_to_object(obj_player);

    // 3. SÓ FUNCIONA se estiver a menos de 45 pixels da porta
    if (_distancia < 2) 
    {
        // 4. Se o jogador apertar a tecla de interagir
        if (keyboard_check_pressed(ord("E"))) 
        {
            // 5. CHECAGEM DO CARTÃO
            if (obj_player.tem_cartao == true) 
            {
                // SÓ ENTRA AQUI SE TIVER O CARTÃO E ESTIVER PERTO
                if (aberta == false) 
                {
                    aberta = true;
                    
                    // FAZ O CARTÃO SUMIR DO PLAYER
                    obj_player.tem_cartao = false; 
                    
                    // INICIA A ANIMAÇÃO LENTA
                    sprite_index = spr_porta_abrindo;
                    image_index = 0;
                    image_speed = 0.15; 
                    
                    show_debug_message("Porta aberta com sucesso!");
                }
            } 
            else 
            {
                // SE NÃO TIVER O CARTÃO, EXIBE O AVISO NO CONTROLADOR
                if (instance_exists(obj_controlador)) 
                {
                    obj_controlador.aviso_timer = 120;
                }
            }
        }
    }
}

// Lógica de mudar de sala (o que já tínhamos)
if (sprite_index == spr_porta_abrindo && image_index >= image_number - 1) 
{
    image_speed = 0;
    image_index = image_number - 1;
    
    if (!variable_instance_exists(id, "timer_saida")) timer_saida = 120;
    timer_saida -= 1;
    
    if (timer_saida <= 0) room_goto_next();
}