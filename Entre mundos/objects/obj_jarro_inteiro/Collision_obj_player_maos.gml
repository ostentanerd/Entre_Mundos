// 1. Checa se é a faca e se o jarro já não está quebrado
if (other.sprite_index == spr_mao_facada && !quebrada) 
{
    quebrada = true;
    image_speed = 1; 

    // --- INICIALIZA A VARIÁVEL (Evita o erro de "not set") ---
    var _item_tipo = noone; 

    // --- LÓGICA DE SORTEIO ---
    if (random(100) < 80) // 80% de chance de cair algo
    {
        if (random(100) < 15) {
            _item_tipo = obj_item_medkit; 
        } else {
            _item_tipo = obj_item_municao;
        }
    }

    // --- CRIAÇÃO SEGURA ---
    // Só tenta criar se _item_tipo NÃO for noone
    if (_item_tipo != noone) 
    {
        var _inst = instance_create_layer(x, y, "Instances", _item_tipo);
        _inst.depth = depth - 1; // Garante que fique na frente
    }
}