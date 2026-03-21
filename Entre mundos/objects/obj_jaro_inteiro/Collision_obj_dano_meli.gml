 // SÓ QUEBRA SE A CONDIÇÃO DE FACADA FOR VERDADEIRA
    if (!quebrada) 
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
            instance_create_layer(x - 15, y - 10, "Velas", _item_tipo);
        }
        
       
    }