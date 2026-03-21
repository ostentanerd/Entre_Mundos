event_inherited();

// 1. PRIMEIRO: Definimos a lista de estados (Enum)
// Se já estiver no Pai, você não precisa repetir, mas o erro indica que ele não achou.
// Vamos garantir que ele exista aqui:
enum ESTADO_NORMAL { PARADO, ANDANDO, ATACANDO, MORTO, CAIDO }

// 2. DEPOIS: Definimos as variáveis básicas
hp = irandom_range(5, 8);
velocidade = 0.5;
dist_atacar = 25;     // Distância em pixels para ele iniciar o ataque
dist_perceber = 150;
flash = 0;
hspeed = 0; // Velocidade horizontal



// 3. POR ÚLTIMO: Sorteamos o estado inicial
// Agora o GameMaker já sabe o que é ESTADO_NORMAL.PARADO etc.
estado = choose(ESTADO_NORMAL.PARADO, ESTADO_NORMAL.ANDANDO, ESTADO_NORMAL.CAIDO);

// 4. Configuração visual do sorteio
if (estado == ESTADO_NORMAL.CAIDO) {
    sprite_index = spr_zumbi_caido; 
    image_index = image_number - 1; 
    image_speed = 0;
}




meu_spawner = noone;


// Sistema de partículas individual do zumbi
global.part_sys = part_system_create();
global.part_sangue = part_type_create();

part_type_shape(global.part_sangue, pt_shape_disk); // Formato de círculo/pingo
part_type_size(global.part_sangue, 0.08, 0.1, -0.005, 0); // Começa médio e diminui
part_type_color1(global.part_sangue, c_red); // Sangue vermelho!
part_type_speed(global.part_sangue, 1.5, 3, -0.1, 0); // Velocidade do espirro
part_type_direction(global.part_sangue, 0, 360, 0, 10); // Espirra para todos os lados
part_type_life(global.part_sangue, 10, 25); // Dura meio segundo na tela

