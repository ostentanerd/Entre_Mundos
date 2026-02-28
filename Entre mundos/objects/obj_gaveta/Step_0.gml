var _interagir = keyboard_check_released(ord("E"));

if (_interagir && distance_to_object(obj_player) < 10 && !aberta) {
    aberta = true;
    image_speed = 1; // Inicia a animação de abrir
    
    // Cria a arma exatamente em cima da gaveta
    // Ajuste o "- 20" para a altura que ficar melhor na sua sprite
    instance_create_layer(x, y - 30, "Instances", obj_item_arma);
	var _item_tipo = noone;
        if (random(100) < 60) 
        {
            if (random(100) < 35) _item_tipo = obj_item_medkit;
            else _item_tipo = obj_item_municao;
        }

        // --- CRIAR O ITEM ---
        if (_item_tipo != noone) 
        {
            instance_create_layer(x - 15, y - 16, "Velas", _item_tipo);
        }
}



///// ---------PROMPT "[E]" ------------

var _dist = distance_to_object(obj_player);
// Se o player estiver perto e a gaveta estiver fechada
if (_dist < 20 && !aberta) {
    // Se o prompt ainda não existe, cria ele
    if (meu_prompt == noone) {
        meu_prompt = instance_create_layer(x, y - 30, "Instances", obj_prompt_interacao);
    }
} 
else {
    // Se o player se afastou ou a gaveta abriu, destrói o prompt
    if (meu_prompt != noone) {
        instance_destroy(meu_prompt);
        meu_prompt = noone;
    }
}