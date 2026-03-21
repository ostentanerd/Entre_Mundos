// 1. A TRANCA: Se o inimigo já estiver morto, não faça nada e saia do código
if (other.hp <= 0) exit;

// 'other' é o inimigo que foi atingido
other.hp -= 1;
other.flash = 1;

 // 1. DEFINIR A DIREÇÃO: Pegamos a direção da bala (other)
    // Usamos part_type_direction para dizer ao sangue para onde ir antes de criá-lo
    var _dir_bala = (obj_player.image_xscale == 1) ? 0 : 180; 
    part_type_direction(other.part_sangue, _dir_bala - 25, _dir_bala + 25, 0, 0);

// Cria 10 gotas de sangue na posição do tiro
repeat(10) {
    part_particles_create(other.part_sys, x, y - 20, other.part_sangue, 1);
	
}

instance_destroy(); // Destrói a bala






