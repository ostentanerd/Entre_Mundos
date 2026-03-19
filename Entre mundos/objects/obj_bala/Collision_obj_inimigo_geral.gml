// 1. A TRANCA: Se o inimigo já estiver morto, não faça nada e saia do código
if (other.hp <= 0) exit;

// 'other' é o inimigo que foi atingido
other.hp -= 1;
other.flash = 1;

// Cria 10 gotas de sangue na posição do tiro
repeat(10) {
    part_particles_create(other.part_sys, x, y - irandom_range(-15, 15), other.part_sangue, 1);
	
}

instance_destroy(); // Destrói a bala