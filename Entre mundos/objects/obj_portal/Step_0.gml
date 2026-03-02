// 1. Checar se o player existe
if (instance_exists(obj_player)) 
{
    var _dist = distance_to_object(obj_player);

    // --- LÓGICA DO PROMPT [E] ---
    if (_dist < 40 && !aberto) 
    {
        if (meu_prompt == noone) {
            meu_prompt = instance_create_layer(x, y - 50, "Instances", obj_prompt_interacao);
        }

        // --- ATIVAR O PORTAL ---
        if (keyboard_check_pressed(ord("E"))) 
        {
            aberto = true;
            sprite_index = spr_portal_abrindo; // Sua sprite do portal abrindo
            image_index = 0;
            image_speed = 1;
            
            // Destrói o prompt assim que interage
            if (meu_prompt != noone) {
                instance_destroy(meu_prompt);
                meu_prompt = noone;
            }
        }
    } 
    else 
    {
        // Se afastar ou o portal já estiver aberto, remove o prompt
        if (meu_prompt != noone) {
            instance_destroy(meu_prompt);
            meu_prompt = noone;
        }
    }
}

// --- LÓGICA DE TRANSIÇÃO (Após abrir) ---
if (aberto) 
{
    // Quando a animação chegar no último frame
    if (image_index >= image_number - 1) 
    {
        image_speed = 0;
        image_index = image_number - 1;
        
        timer_saida -= 1;
        
        // --- DENTRO DO IF (timer_saida <= 0) ---

		if (timer_saida <= 0) 
		{
		    if (!instance_exists(obj_transicao)) 
		    {
		        // FAZ O PLAYER SUMIR (Efeito de entrada no portal)
		        if (instance_exists(obj_player)) {
		            obj_player.visible = false;
		        }

		        var _tran = instance_create_depth(0, 0, -9999, obj_transicao);
		        _tran.destino = rm_fase_2; 
		        _tran.estado = 1;
				
				// Se você tiver um sistema de câmera com shake:
				global.camera_shake = 10; 
				
				// Ou um som de teletransporte:
				//audio_play_sound(snd_portal_suction, 1, false);
        
		        timer_saida = 999; 
		    }
		}
    }
}