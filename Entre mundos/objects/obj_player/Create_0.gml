// Movimentação básica
hsp       = 0;
vsp       = 0;
grv       = 0.3;
walksp    = 1;
jumpsp    = 4;  // Corrigido o nome
face      = 1;

// Sistema de lanterna

lanterna_ligada  = false;
lanterna_raio    = 80;
surf             = -1; 

// Inventario e Mãos
mao_atual    = 0; 
tem_cartao   = false;
pode_atirar  = true;
delay_tiro   = 5;
municao      = 0;
brilho_tiro = 0;
tem_pistola = false; // Começa sem a arma

vida_max = 5; // O total de vida que ele pode ter
vida = vida_max; // A vida atual dele
morto = false;


tem_cartao = false; // Começa sem o cartão


flash_player = 0;
invulneravel = false; // Novo: controla se o player pode levar dano
tempo_invulneravel = 60; // 1 segundo de proteção (60 frames)
pode_tomar_dano = true;
distancia_knockback = 4; // Força do empurrão


// Criando o objeto das mãos
meus_bracos = instance_create_layer(x, y, "Instances", obj_player_maos);

meu_lanterna = instance_create_layer(x, y, "Lanterna", obj_lanterna_apagada);



////  -----------SANGUE---------

// 1. Criamos o sistema (o gerenciador das partículas)
global.part_sistema = part_system_create();

// 2. Criamos o tipo (a aparência da gota de sangue)
global.part_sangue = part_type_create();


// Definindo uma cor personalizada (marrom/vermelho escuro)
var _sangue_escuro = make_color_rgb(139, 0, 0); // Cor de sangue seco/vinho

part_type_shape(global.part_sangue, pt_shape_disk);   // Formato de círculo
part_type_size(global.part_sangue, 0.03, 0.04, 0, 0);   // Tamanho (bem pequeno)
part_type_color1(global.part_sangue, _sangue_escuro);         // Cor vermelha
part_type_speed(global.part_sangue, 1, 2, -0.07, 0);   // Velocidade de saída
part_type_direction(global.part_sangue, 0, 360, 0, 0);// Direção (para todos os lados)
part_type_gravity(global.part_sangue, 0.5, 270);      // Gravidade (270 é para baixo)
part_type_life(global.part_sangue, 5, 10);           // Quanto tempo dura (frames)