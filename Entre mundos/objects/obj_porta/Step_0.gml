// 1. Checar se o player existe para não dar erro
if (instance_exists(obj_player)) 
{
    var _distancia = distance_to_object(obj_player);

    // 3. SÓ FUNCIONA se estiver a menos de 40 pixels e luz acesa
    if (_distancia < 30 && global.luz_acesa)
    {
        if (keyboard_check_pressed(ord("E"))) 
        {
            if (global.tem_cartao == true) 
            {
                if (aberta == false) 
                {
                    aberta = true;
                    global.tem_cartao = false; 
                    
                    sprite_index = spr_porta_abrindo;
                    image_index = 0;
                    image_speed = 0.35; 
                    
                    show_debug_message("Porta aberta com sucesso!");
                }
            } 
            else 
            {
                if (instance_exists(obj_controlador)) 
                {
                    obj_controlador.aviso_timer = 90;
                }
            }
        }
    }
}

// --- LÓGICA DE TRANSIÇÃO COM O OBJETO NOVO ---
if (sprite_index == spr_porta_abrindo && image_index >= image_number - 1) 
{
    image_speed = 0;
    image_index = image_number - 1;
    
    if (!variable_instance_exists(id, "timer_saida")) timer_saida = 80;
    timer_saida -= 1;
    
    // Quando o timer zerar, chamamos a transição em vez de mudar de sala direto
    if (timer_saida <= 0) 
    {
        if (!instance_exists(obj_transicao)) 
        {
            var _tran = instance_create_depth(0, 0, -9999, obj_transicao);
            
            // Aqui você escolhe: 
            // room_next(room) leva para a próxima sala na lista
            // rm_terra_2149 levaria para uma sala específica
            _tran.destino = room_next(room); 
            
            // Resetamos o timer para não criar mil transições
            timer_saida = 999; 
        }
    }
}

///// --------- PROMPT "[E]" ------------
var _dist = distance_to_object(obj_player);
if (_dist < 20 && !aberta && global.luz_acesa) 
{
    if (meu_prompt == noone) {
        meu_prompt = instance_create_layer(x - 20, y - 45, "Instances", obj_prompt_interacao);
    }
} 
else {
    if (meu_prompt != noone) {
        instance_destroy(meu_prompt);
        meu_prompt = noone;
    }
}