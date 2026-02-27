event_inherited();

// 1. PRIMEIRO: Definimos a lista de estados (Enum)
// Se já estiver no Pai, você não precisa repetir, mas o erro indica que ele não achou.
// Vamos garantir que ele exista aqui:
enum ESTADO_NORMAL { PARADO, ANDANDO, ATACANDO, MORTO, CAIDO }

// 2. DEPOIS: Definimos as variáveis básicas
hp = irandom_range(5, 8);
velocidade = 0.5;
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

