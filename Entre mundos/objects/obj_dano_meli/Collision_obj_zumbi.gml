// Evento Collision com obj_zumbi
if (instance_exists(other)) {
    // 1. Tira o dano
    other.hp -= dano;
    
    // 2. Mostra no console o HP exato que sobrou
    show_debug_message("Zumbi atingido! HP restante: " + string(other.hp));
    
    // 3. Feedback visual
    other.flash = 1;
	
	// No evento de colisão, antes de criar a partícula:
	var _dir = (obj_player.face == 1) ? 0 : 180; // Direita ou Esquerda
	part_type_direction(global.part_sangue, _dir - 45, _dir + 45, 0, 0); 
	part_particles_create(global.part_sistema, other.x, other.y - irandom_range(-15, 15), global.part_sangue, 10);
   // --- EXPLOSÃO DE SANGUE ---
    // Argumentos: Sistema, X, Y, Tipo de Partícula, Quantidade
    part_particles_create(global.part_sistema, other.x, other.y - 10, global.part_sangue, 15);

    instance_destroy();
}