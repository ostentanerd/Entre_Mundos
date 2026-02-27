var _key_fire  = keyboard_check_pressed(ord("K"));
var _key_knife = keyboard_check_pressed(ord("I"));

// --- LÓGICA DE ATAQUE ---
if ((_key_fire || _key_knife) && obj_player.pode_atirar) 
{
    // Se for tiro (K + Bala + Pistola)
    if (_key_fire && obj_player.tem_pistola && obj_player.municao > 0) 
    {
        sprite_index = spr_mao_pistola_atirando;
        image_index = 0; // Resetar o frame ANTES
        image_speed = 1;
        
        var _bala = instance_create_layer(x + (obj_player.face * 18), y - 5, "Bala", obj_bala);
        _bala.direction = (obj_player.face == 1) ? 0 : 180;
        _bala.speed = 12;
        _bala.image_xscale = obj_player.face;

        obj_player.brilho_tiro = 1; 
        obj_player.municao -= 1;
        obj_player.pode_atirar = false;
        obj_player.alarm[0] = obj_player.delay_tiro;
        
        if (instance_exists(obj_camera)) {
            obj_camera.shake_power = 2;
            obj_camera.shake_intensidade = 1;
        }
    }
    // CASO B: Esfaquear (I ou K sem bala)
    else 
    {
        sprite_index = spr_mao_pistola_facada; 
        image_index = 0; // Garante que começa do frame 0
        image_speed = 1; 
        
        var _inst = instance_create_layer(x + (obj_player.face * 20), y - 10, "Instances", obj_dano_meli);
        _inst.dano = 2; 
        
        obj_player.pode_atirar = false;
        obj_player.alarm[0] = 30; // Certifique-se que o Alarme 0 do Player é longo o suficiente!
    }
}

// --- LOGICA DE RETORNO AUTOMÁTICO ---
if (sprite_index == spr_mao_pistola_atirando || sprite_index == spr_mao_pistola_facada)
{
    // Usamos -0.5 para dar uma margem de segurança e a animação chegar no último frame visual
    if (image_index >= image_number - 0.5)
    {
        sprite_index = spr_mao_pistola;
        image_index = 0;
        image_speed = 1; // Para o braço parado não ficar "piscando" ou animando
    }
}