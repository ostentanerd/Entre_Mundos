// Desenha a lanterna normalmente
draw_self();

// Se estiver acesa, desenha o cone de luz com brilho extra (aditivo)
if (sprite_index == spr_lanterna_acesa) {
    gpu_set_blendmode(bm_add); // Faz a luz brilhar e clarear o fundo
    draw_sprite_ext(sprite_index, image_index, x, y, image_xscale, image_yscale, 0, c_white, 0.4);
    gpu_set_blendmode(bm_normal); // Volta ao normal
}
if (global.luz_acesa) {
    // Se a luz está acesa, a colisão da lanterna é o cone de luz
    mask_index = spr_luz_suave; 
} else {
    // Se está apagada, a lanterna não tem corpo (não bate em nada)
    mask_index = spr_vazio; // Ou o sprite da lanterna desligada
}