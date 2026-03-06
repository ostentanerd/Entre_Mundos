/// @description Colisão com o Inimigo

// Se o inimigo (other) não existir ou já estiver no estado de MORTO, ignoramos totalmente
if (!instance_exists(other) || other.hp <= 0) 
{
    // O comando 'exit' faz a bala ignorar o resto deste código
    // Como o instance_destroy() está lá embaixo, a bala NÃO morre.
    exit; 
}

// --- DAQUI PARA BAIXO SÓ RODA SE O ZUMBI ESTIVER VIVO ---

// 1. Tira vida
other.hp -= 1;
other.flash = 1;

// 2. Sangue
repeat(10) {
    part_particles_create(other.part_sys, x, y - 15, other.part_sangue, 1);
}

// 3. AGORA SIM a bala morre
instance_destroy();