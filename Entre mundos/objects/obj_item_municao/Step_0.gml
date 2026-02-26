event_inherited();




// Colisão simples com o chão para o item não cair pelo mapa
if (place_meeting(x, y + 1, obj_chao_normal)) { // Substitua obj_chao pelo nome do seu objeto de colisão
    vspeed = 0;
    gravity = 0;
    hspeed = 0;
}