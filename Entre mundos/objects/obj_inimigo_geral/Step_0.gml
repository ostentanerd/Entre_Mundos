/// @description Inteligência Universal

// 1. CHECAR SE O PLAYER EXISTE
if (!instance_exists(obj_player)) { hspeed = 0; exit; }

// 2. VARIÁVEIS DE DISTÂNCIA
var _dist = point_distance(x, y, obj_player.x, obj_player.y);

// 3. SISTEMA DE DANO E MORTE
if (flash > 0) flash -= 0.1; // Diminui o efeito branco

// 2. LÓGICA DE MORTE DO ZUMBI
if (hp <= 0) 
{
    // TROCAMOS E_ESTADO.MORTO POR "MORTO"
    if (estado != "MORTO") 
    {
        estado = "MORTO";
        
        // --- LIMPEZA TOTAL DE COLISÃO ---
        mask_index = -1;     
        solid = false;       
        image_speed = 1;
        image_index = 0;     
        hspeed = 0;
        vspeed = 0;
        var _item_tipo = noone;

        // --- LÓGICA DE DROP ORGANIZADA ---
        
        // 1. Prioridade Máxima: Cartão (Se for o último do spawner)
        if (instance_exists(meu_spawner)) 
        {
            meu_spawner.vivos -= 1; 
            
            if (meu_spawner.vivos <= 0) {
                _item_tipo = obj_item_cartao;
            }
        }

        // 2. Se não for cartão, tenta o drop comum (Medkit ou Munição)
        if (_item_tipo == noone) 
        {
            // Chance de dropar algo (50% se veio de spawner, 40% se estava na sala)
            var _chance = instance_exists(meu_spawner) ? 50 : 40; 
            
            if (random(100) < _chance)
            {
                // 15% de ser Medkit, o resto Munição
                if (random(100) < 15) {
                    _item_tipo = obj_item_medkit;
                } else {
                    _item_tipo = obj_item_municao;
                }
            }
        }

        // 3. Criar o item se ele foi definido
        if (_item_tipo != noone) 
        {
            // Usa a layer "Inimigo" ou a que o zumbi já está
            var _target_layer = layer_exists("Inimigo") ? "Inimigo" : layer;
            
            var _it = instance_create_layer(x, y, _target_layer, _item_tipo);
            
            // Pequeno pulo para cima ao dropar
            if (variable_instance_exists(_it, "vspeed")) _it.vspeed = -2; 
            
            show_debug_message("Dropou: " + object_get_name(_item_tipo));
        }
    }

    // --- FINALIZAÇÃO VISUAL DA MORTE ---
    sprite_index = spr_morto; // Usa a variável que definimos no Create!

    if (image_index >= image_number - 1) 
    {
        image_speed = 0;
        image_index = image_number - 1;
        
        // Sumir devagar após a animação acabar
        image_alpha -= 0.01; 
        if (image_alpha <= 0) instance_destroy();
    }
    
    exit; // Importante: não executa mais nada do Step se estiver morto
}

// 4. MÁQUINA DE ESTADOS
switch (estado) 
{
	
	case "PATRULHANDO":
    sprite_index = spr_andando;
    image_speed = 0.5;
    
    // 1. Definir direção para o destino atual
    var _dir_patrulha = sign(destino_x - x);
    if (_dir_patrulha != 0) image_xscale = (_dir_patrulha > 0) ? -1 : 1;
    
    // 2. Movimentar
    x += _dir_patrulha * (velocidade * 0.5); // Anda mais devagar na patrulha
    
    // 3. Checar se chegou no destino para inverter
    if (abs(x - destino_x) < 5) {
       destino_x = (destino_x == ponto_b) ? ponto_a : ponto_b;
    }
    
    // 4. Se ver o player, persegue!
    if (_dist < dist_perceber) {
        estado = "ANDANDO";
    }
	break;
	
	
    case "PARADO":
        sprite_index = spr_parado;
        image_speed = 1;
        hspeed = 0;
        if (_dist < dist_perceber) {
            estado = "ANDANDO";
        }
    break;

    case "ANDANDO":
        sprite_index = spr_andando;
        image_speed = 1;
        image_xscale = (obj_player.x > x) ? -1 : 1; // Vira para o player
        
        var _dir = point_direction(x, y, obj_player.x, obj_player.y);
        hspeed = lengthdir_x(velocidade, _dir);

        if (_dist <= dist_atacar) {
            estado = "ATACANDO";
            image_index = 0;
        }
    break;

    case "ATACANDO":
    hspeed = 0;
    sprite_index = spr_ataque;
    image_speed = 1;
    
    if (image_index >= image_number - 1) {
        // Checa distância e se o player NÃO está invulnerável
        if (_dist < dist_atacar + 10 && obj_player.invulneravel == false) {
            global.vida -= 1; // Tira vida da variável GLOBAL
            obj_player.invulneravel = true;
            obj_player.alarm[1] = 60; // 1 segundo de proteção
            
            // Um pequeno empurrão no player (Knockback)
            obj_player.hsp = (obj_player.x > x) ? 4 : -4;
        }
        estado = "ANDANDO"; 
    }
    break;
	
	
	
	
}