/// @description Efeito de Flash Branco
draw_self(); // Desenha ele normal

if (flash > 0) {
    gpu_set_fog(true, c_white, 0, 0); // Ativa o "nevoeiro" branco sobre o sprite
    draw_self();
    gpu_set_fog(false, c_white, 0, 0); // Desativa
}