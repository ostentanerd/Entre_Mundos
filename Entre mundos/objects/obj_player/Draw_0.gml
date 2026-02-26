// 1. Lógica da transparência (Piscar)
// Só pisca se estiver invulnerável E ainda estiver vivo
if (invulneravel && vida > 0) {
    image_alpha = ((current_time div 100) % 2 == 0) ? 0.3 : 1.0;
} else {
    // Se estiver morto ou não estiver invulnerável, o alpha é normal
    image_alpha = 1.0;
}

// 2. Desenho com Flash Vermelho ou Normal
if (flash_player > 0 && vida > 0) { // Também só mostra o flash vermelho se estiver vivo
    flash_player -= 0.05;
    gpu_set_fog(true, c_white, 0, 0);
    draw_sprite_ext(sprite_index, image_index, x, y, image_xscale, image_yscale, image_angle, image_blend, image_alpha);
    gpu_set_fog(false, c_white, 0, 0);
} else {
    draw_sprite_ext(sprite_index, image_index, x, y, image_xscale, image_yscale, image_angle, image_blend, image_alpha);
}