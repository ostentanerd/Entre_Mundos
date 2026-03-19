// Desenha o zumbi normalmente
draw_self();

// Se levou tiro, desenha uma silhueta branca por cima
if (flash > 0) {
    gpu_set_fog(true, c_white, 0, 0);
    draw_sprite_ext(sprite_index, image_index, x, y, image_xscale, image_yscale, image_angle, image_blend, flash);
    gpu_set_fog(false, c_white, 0, 0);
}