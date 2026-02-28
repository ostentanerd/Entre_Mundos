// 1. Criamos uma variável local para decidir se desenha ou não
var _exibir_elevador = false;

if (global.luz_acesa) {
    // 2. Checamos se a lanterna (com a máscara da luz) está colidindo com o elevador
    if (instance_exists(obj_lanterna)) {
        // O place_meeting checa se o sprite da lanterna encosta no elevador
        if (place_meeting(x, y, obj_lanterna)) {
            _exibir_elevador = true;
        }
    }
}

// 3. Só desenha se a luz estiver realmente "batendo"
if (_exibir_elevador) {
    draw_self();
    
    // Efeito de brilho quando a luz bate
    gpu_set_blendmode(bm_add);
    draw_sprite_ext(sprite_index, image_index, x, y, image_xscale, image_yscale, 0, c_white, 0.2);
    gpu_set_blendmode(bm_normal);
}