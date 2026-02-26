event_inherited();

image_xscale = 0.8;
image_yscale = 0.8;



// Criar partículas ao redor do cartão
// Ajustamos x e y com um pequeno valor aleatório para espalhar o brilho
part_particles_create(sistema_brilho, x + random_range(-4, 4), y + random_range(-4, 4), tipo_brilho, 1);


// Colisão simples com o chão para o item não cair pelo mapa
if (place_meeting(x, y + 1, obj_chao_normal)) { // Substitua obj_chao pelo nome do seu objeto de colisão
    vspeed = 0;
    gravity = 0;
    hspeed = 0;
}