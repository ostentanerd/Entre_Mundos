var _interagir = keyboard_check_released(ord("E"));

if (_interagir && distance_to_object(obj_player) < 10 && !aberta) {
    aberta = true;
    image_speed = 1; // Inicia a animação de abrir
    
    // Cria a arma exatamente em cima da gaveta
    // Ajuste o "- 20" para a altura que ficar melhor na sua sprite
    instance_create_layer(x, y - 30, "Instances", obj_item_arma);
}