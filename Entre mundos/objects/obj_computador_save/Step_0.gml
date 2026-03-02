var _dist = distance_to_object(obj_player);

// SÓ FUNCIONA SE: Distância < 30 E o save global NÃO estiver bloqueado
if (_dist < 30 && global.save_bloqueado == false) 
{
    if (meu_prompt == noone) {
        meu_prompt = instance_create_layer(x-2, y - 18, "Instances", obj_prompt_interacao);
    }

    if (keyboard_check_pressed(ord("E"))) 
    {
        global.save_bloqueado = true; 
        timer_texto = 90; // Ativa o texto por 1.5 segundos
        
        // --- SEUS DADOS DE SAVE ---
        global.checkpoint_room = room;
        global.checkpoint_x = x;
        global.checkpoint_y = y + 20;
        global.save_municao = global.municao;
        global.save_medkits = global.medkits;
        global.save_vida = 5;

        if (meu_prompt != noone) {
            instance_destroy(meu_prompt);
            meu_prompt = noone;
        }
    }
} 
else 
{
    if (meu_prompt != noone) {
        instance_destroy(meu_prompt);
        meu_prompt = noone;
    }
    
    // PC fica vermelho se já foi usado
    if (global.save_bloqueado) image_blend = c_red;
}

// Diminui o timer do texto se ele estiver ativo
if (timer_texto > 0) timer_texto -= 1;