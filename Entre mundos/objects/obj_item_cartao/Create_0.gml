event_inherited()

// 1. Criamos o Sistema de Partículas
sistema_brilho = part_system_create();
part_system_depth(sistema_brilho, depth  + 1); // Garante que o brilho fique na frente do item

// 2. Criamos o Tipo de Partícula (o visual do brilho)
tipo_brilho = part_type_create();
part_type_shape(tipo_brilho, pt_shape_spark);    // Formato de faísca/estrela
part_type_size(tipo_brilho, 0.1, 0.3, -0.01, 0); // Tamanho aleatório que diminui
part_type_color1(tipo_brilho, c_yellow);         // Cor amarela (ou c_white para branco)
part_type_alpha2(tipo_brilho, 1, 0);             // Começa visível e some (fade out)
part_type_speed(tipo_brilho, 0.3, 1, -0.02, 0);  // Velocidade lenta para cima
part_type_direction(tipo_brilho, 0, 359, 0, 0);  // Direção aleatória (360 graus)
part_type_life(tipo_brilho, 20, 40);             // Tempo de vida curto (frames)



image_blend = c_yellow; // Deixa o sprite amarelado/brilhante

image_xscale = 0.6;
image_yscale = 0.6;

tipo  =  "cartao";
