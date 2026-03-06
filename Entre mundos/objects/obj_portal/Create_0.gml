aberto = false;
meu_prompt = noone;
timer_saida = 80; // Tempo de espera após a animação abrir
image_speed = 1;  // Começa parado (fechado)



// 1. Criar o Sistema (O "balde" de partículas)
meu_sistema = part_system_create();

// 2. Criar o Tipo da Partícula (O "DNA" da partícula)
minha_particula = part_type_create();

part_type_sprite(minha_particula, spr_particula_pixel, false, false, false); // Use um pixel ou circulo pequeno
part_type_size(minha_particula, 0.3, 0.5, -0.01, 0); // Começa média e diminui
part_type_color2(minha_particula, c_purple, c_fuchsia); // Muda de roxo para preto (efeito de vácuo)
part_type_alpha3(minha_particula, 0, 1, 0); // Surge do nada, brilha e some
part_type_speed(minha_particula, 1, 3, -0.05, 0); // Vai para fora e desacelera
part_type_direction(minha_particula, 0, 360, 0, 0); // Voa para todos os lados
part_type_life(minha_particula, 40, 60); // Quanto tempo ela vive