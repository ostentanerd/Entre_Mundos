global.cutscene = false;

// Garante que o player volte a ter velocidade de animação
if (instance_exists(obj_player)) {
    obj_player.image_speed = 1; 
}