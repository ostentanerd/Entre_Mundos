event_inherited();


// 1. SE O PLAYER MORREU (E o zumbi está vivo), ele entra em modo patrulha
if (instance_exists(obj_player) && obj_player.vida <= 0 && hp > 0) { 
    if (estado != ESTADO_NORMAL.PARADO && estado != ESTADO_NORMAL.ANDANDO) {
        estado = ESTADO_NORMAL.PARADO;
    }
}

// 2. LÓGICA DE MORTE DO ZUMBI (Deve vir PRIMEIRO de tudo)
if (hp <= 0) {
    if (estado != ESTADO_NORMAL.MORTO) {
        estado = ESTADO_NORMAL.MORTO;
        
        // --- LIMPEZA TOTAL DE COLISÃO ---
        mask_index = -1;     // Remove o corpo físico
        solid = false;       // Garante que não é sólido
        image_speed = 1;
        hspeed = 0;
        vspeed = 0;

        var _item_tipo = noone;

        // --- DROP DE ITENS ---
        if (instance_exists(meu_spawner)) {
            meu_spawner.vivos -= 1; 
			
            if (meu_spawner.vivos <= 0) _item_tipo = obj_item_cartao;
            else if (random(100) < 40) _item_tipo = obj_item_municao;
        } else {
            if (random(100) < 30) _item_tipo = obj_item_municao;
        }

        if (_item_tipo != noone) {
            var _lay = layer_exists("Instances_1") ? "Instances_1" : layer;
            var _it = instance_create_layer(x, y, _lay, _item_tipo);
            _it.vspeed = -4;
            _it.gravity = 0; // Adicionado gravidade para o item não voar
        }
		
		
    }

    // Mantém o sprite de morto e faz sumir
    sprite_index = spr_zumbi_morto;
    if (image_index >= image_number - 1) {
        image_speed = 0;
        image_index = image_number - 1;
        image_alpha -= 0.01; // Sumir um pouco mais rápido (ajuste se preferir)
        if (image_alpha <= 0) instance_destroy();
    }
    exit; // Se o zumbi está morto, ignora todo o resto abaixo
}

// 3. SE O PLAYER MORREU (E o zumbi está vivo), O ZUMBI PARA
if (obj_player.vida <= 0) {
    hspeed = 0;
    estado = ESTADO_NORMAL.PARADO;
    sprite_index = spr_zumbi_idle;
    image_speed = 0.5;
    exit; 
}

// 4. DEFINIR A DISTÂNCIA (O player está vivo e o zumbi também)
var _dist = point_distance(x, y, obj_player.x, obj_player.y);



///  ------------- SWITCH --------------
// 5. MÁQUINA DE ESTADOS
		switch (estado) {
		   case ESTADO_NORMAL.PARADO:
    sprite_index = spr_zumbi_idle;
    hspeed = 0;

    // Se o player estiver vivo e perto, persegue
    if (instance_exists(obj_player) && obj_player.vida > 0) {
        if (_dist < dist_perceber) {
            estado = ESTADO_NORMAL.ANDANDO;
        }
    } 
    else {
        // --- LÓGICA DE PATRULHA ---
        // Se o alarme não estiver a correr (valor -1), nós ligamos ele
        if (alarm[0] <= 0) {
            alarm[0] = room_speed * 3; // 3 segundos para a próxima decisão
            
            if (random(100) > 50) { // 50% de chance de andar
                estado = ESTADO_NORMAL.ANDANDO;
                // Escolhe esquerda ou direita
                var _lado = choose(-1, 1);
                hspeed = _lado * (velocidade * 0.5); // Anda mais devagar na patrulha
                image_xscale = (_lado > 0) ? -1 : 1;
            }
        }
    }
break;

		   case ESTADO_NORMAL.ANDANDO:
    sprite_index = spr_zumbi_andando;
    
    if (instance_exists(obj_player) && obj_player.vida > 0) {
        // Código normal de seguir o player que já tens...
        image_xscale = (obj_player.x > x) ? -1 : 1;
        var _dir = point_direction(x, y, obj_player.x, obj_player.y);
        hspeed = lengthdir_x(velocidade, _dir);
    } else {
        // Se o player morreu, ele mantém a velocidade da patrulha
        // e se bater numa parede, para.
        if (place_meeting(x + hspeed, y, obj_chao_normal)) {
            hspeed = 0;
            estado = ESTADO_NORMAL.PARADO;
        }
    }
break;

		   case ESTADO_NORMAL.ATACANDO:
		    hspeed = 0;
		    // Se o zumbi morrer enquanto ataca, cancela tudo
		    if (hp <= 0) { 
		        estado = ESTADO_NORMAL.MORTO; 
		        exit; 
		    }

		    sprite_index = spr_zumbi_atacando;
		    image_speed = 1;
    
		    if (image_index >= image_number - 1) {
		        // SÓ aplica dano se o zumbi estiver VIVO (hp > 0)
		        if (hp > 0 && _dist < dist_atacar + 10 && obj_player.vida > 0 && obj_player.invulneravel == false) {
		            obj_player.vida -= 1;
		            obj_player.invulneravel = true;
		            obj_player.alarm[1] = 60;
		            // ... knockback
		        }
		        estado = ESTADO_NORMAL.ANDANDO;
		    }
		break;
		
		case ESTADO_NORMAL.CAIDO:
    hspeed = 0;
    // Se o player chegar muito perto, o zumbi levanta
    if (instance_exists(obj_player)) {
        var _dist = distance_to_object(obj_player);
        if (_dist < 50) { // Distância para ele "acordar"
            estado = ESTADO_NORMAL.ANDANDO; 
            image_speed = 1;
            // Aqui podes colocar uma animação dele levantando se tiveres!
        }
    }
    break;
}