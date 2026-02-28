// 1. Variáveis de entrada e distância
var _distancia = distance_to_object(obj_player);
var _tecla_faca = keyboard_check_pressed(ord("I"));
var _tecla_tiro = keyboard_check_pressed(ord("K"));

// 2. Lógica para saber se o player REALMENTE deu uma facada
// Ele dá facada se: Apertar I OU (Apertar K e não ter munição)
var _deu_facada = (_tecla_faca) || (_tecla_tiro && obj_player.municao <= 0);

// 3. Verificação de proximidade e se já não está quebrada
if (_distancia < 5 && !quebrada) 
{
    // SÓ QUEBRA SE A CONDIÇÃO DE FACADA FOR VERDADEIRA
    if (_deu_facada) 
    {
        quebrada = true;
        image_speed = 1; // Inicia a animação do item quebrando
        
        // --- SORTEIO DO ITEM (Sua lógica de 80%) ---
        var _item_tipo = noone;
        if (random(100) < 80) 
        {
            if (random(100) < 15) _item_tipo = obj_item_medkit;
            else _item_tipo = obj_item_municao;
        }

        // --- CRIAR O ITEM ---
        if (_item_tipo != noone) 
        {
            instance_create_layer(x - 15, y - 16, "Velas", _item_tipo);
        }
        
       
    }
}