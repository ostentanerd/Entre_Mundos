// Desenha a lanterna normalmente
draw_self();

// Se estiver acesa, desenha o cone de luz com brilho extra (aditivo)
if (sprite_index == spr_lanterna_acesa) {
    gpu_set_blendmode(bm_add); // Faz a luz brilhar e clarear o fundo
    draw_sprite_ext(sprite_index, image_index, x, y, image_xscale, image_yscale, 0, c_white, 0.4);
    gpu_set_blendmode(bm_normal); // Volta ao normal
}