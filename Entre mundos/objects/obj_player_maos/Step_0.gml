var _key_fire = keyboard_check_pressed(ord("K"));

// --- LÓGICA DE ATAQUE ---
if (_key_fire && obj_player.pode_atirar)
{
   // NOVO: Só tenta atirar se o player REALMENTE tiver a pistola
    if (obj_player.tem_pistola && obj_player.municao > 0) 
    {
        var _bala = instance_create_layer(x + (obj_player.face * 18), y - 5, "Bala", obj_bala);
        _bala.direction = (obj_player.face == 1) ? 0 : 180;
        _bala.speed = 12;
        _bala.image_xscale = obj_player.face;

        sprite_index = spr_mao_pistola_atirando;
        image_index = 0;
        image_speed = 1;
        
        obj_player.brilho_tiro = 1; 
        obj_player.municao -= 1;
        obj_player.pode_atirar = false;
        obj_player.alarm[0] = obj_player.delay_tiro;
    }
    // CASO B: NÃO TEM MUNIÇÃO (ESFAQUEIA)
    else 
	{
	    sprite_index = spr_mao_pistola_facada; 
	    image_index = 0;
	    image_speed = 1; 
	    
	    // CRIAR O DANO APENAS UMA VEZ AQUI
	    var _inst = instance_create_layer(x + (obj_player.face * 20), y - 10, "Instances", obj_dano_meli);
	    _inst.dano = 2; // Tente baixar o dano para 1 para testar
	    
	    obj_player.pode_atirar = false;
	    obj_player.alarm[0] = 30; 
	}
}

// --- LOGICA DE RETORNO AUTOMÁTICO ---
// Isso faz o braço voltar ao normal quando terminar de atirar ou esfaquear
if (sprite_index == spr_mao_pistola_atirando || sprite_index == spr_mao_pistola_facada)
{
    if (image_index >= image_number - 1)
    {
        sprite_index = spr_mao_pistola;
        image_speed = 0; 
        image_index = 0;
    }
}