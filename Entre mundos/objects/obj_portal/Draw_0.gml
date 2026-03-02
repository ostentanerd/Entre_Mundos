// Desenha o portal normalmente
draw_self();

// Se estiver aberto, desenha um brilho (Glow)
if (aberto) {
    gpu_set_blendmode(bm_add);
    // Desenha o próprio portal com um pouco de transparência e maior para simular brilho
    draw_sprite_ext(sprite_index, image_index, x, y, 1.1, 1.1, 0, c_purple, 0.3);
    gpu_set_blendmode(bm_normal);
}