// 1. Checar se o player existe
if (instance_exists(obj_player)) 
{
    var _dist = distance_to_object(obj_player);

    // ESTADO 0: FECHADO (Esperando interação)
    if (!aberto && _dist < 40) 
    {
        if (meu_prompt == noone) {
            meu_prompt = instance_create_layer(x, y - 50, "Instances", obj_prompt_interacao);
        }

        if (keyboard_check_pressed(ord("E"))) 
        {
            aberto = true; // Muda para o estado "Abrindo"
            sprite_index = spr_portal_abrindo; 
            image_index = 0;
            image_speed = 1;
            
            if (meu_prompt != noone) {
                instance_destroy(meu_prompt);
                meu_prompt = noone;
            }
        }
    } 
    else if (_dist >= 40 && meu_prompt != noone) 
    {
        instance_destroy(meu_prompt);
        meu_prompt = noone;
    }
}

// 2. LÓGICA DE TRANSIÇÃO E TROCA DE ANIMAÇÃO
if (aberto) 
{
    // Se a animação de "Abrindo" terminou
    if (sprite_index == spr_portal_abrindo && image_index >= image_number - 1) 
    {
        // TROCA PARA A SEGUNDA ANIMAÇÃO (O portal girando/aberto)
        sprite_index = spr_portal_abrindo; // <-- Coloque o nome da sua 2ª sprite aqui
        image_index = 0;
        image_speed = 1;
    }

    // Se já estiver na animação final, começa a contagem para mudar de fase
    if (sprite_index == spr_portal_abrindo) 
    {
        timer_saida -= 1;

        if (timer_saida <= 0) 
        {
            if (!instance_exists(obj_transicao)) 
            {
                if (instance_exists(obj_player)) obj_player.visible = false;

                var _tran = instance_create_depth(0, 0, -9999, obj_transicao);
                _tran.destino = rm_fase_2; 
                _tran.estado = 1;
                
                global.camera_shake = 10; 
                timer_saida = 999; // Trava o timer para não criar mil transições
            }
        }
    }
}

// Adicione isso dentro do seu código onde o portal já está em loop:
if (sprite_index == spr_portal_abrindo) 
{
    // Cria 2 partículas por frame em posições aleatórias ao redor do centro do portal
    repeat(2) {
        var _xx = x + random_range(-15, 15);
        var _yy = y + random_range(-15, 15);
        part_particles_create(meu_sistema, _xx, _yy, minha_particula, 1);
    }
}