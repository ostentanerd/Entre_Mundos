/// @description DNA do Inimigo

// --- 1. IDENTIDADE (Mude isso na aba "Variables" da Room para cada zumbi) ---
if (!variable_instance_exists(id, "tipo_inimigo")) {
    tipo_inimigo = "normal"; // Valor padrão caso você esqueça de definir
}

// --- 2. VARIÁVEIS DE COMBATE GERAIS ---
hp = 3;
velocidade = 0.5;
dist_perceber = 150;
dist_atacar = 25;
flash = 0; // Para o efeito de dano branco


// Variáveis de Patrulha
ponto_a = x;                // Ponto inicial (onde ele nasce)
ponto_b = x + 100;          // Ponto final (100 pixels para a direita)
destino_x = ponto_b;        // Para onde ele está indo agora
// No Create, em vez de x + 100
ponto_b = x + irandom_range(-200, 200);
//estado = "PATRULHANDO";      // Começar patrulhando



// --- 3. DEFINIÇÃO DE SKINS E COMPORTAMENTO POR TIPO ---
// Aqui é onde você "veste" o zumbi
switch (tipo_inimigo) 
{
    case "normal":
        spr_parado  = spr_zumbi_idle;
        spr_andando = spr_zumbi_andando;
        spr_ataque  = spr_zumbi_atacando;
        spr_morto   = spr_zumbi_morto;
		hp          = choose(3, 5, 7); // Zumbi comum
        velocidade  = 0.5;
        estado      = "PARADO"; 
    break;
	
	 case "patrulhan":
        spr_parado  = spr_zumbi_idle;
        spr_andando = spr_zumbi_andando;
        spr_ataque  = spr_zumbi_atacando;
        spr_morto   = spr_zumbi_morto;
		hp          = choose(3, 5, 7); // Zumbi comum
        velocidade  = 0.5;
        estado = "PATRULHANDO";      // Começar patrulhando
    break;

    case "caido":
        spr_parado  = spr_zumbi_caido; // Skin deitado
        spr_andando = spr_zumbi_andando;
        spr_ataque  = spr_zumbi_atacando;
        spr_morto   = spr_zumbi_morto;
		hp          = choose(3, 5, 7); // Zumbi comum
        velocidade  = 0.5;
        estado      = "PARADO"; 
        dist_perceber = 80; // Ele "dorme" mais pesado, precisa chegar perto
    break;
	
	// PLANO B: Se o nome vier errado do Spawner, ele usa o normal
    default:
        spr_parado  = spr_zumbi_idle;
        spr_andando = spr_zumbi_andando;
        spr_ataque  = spr_zumbi_atacando;
        spr_morto   = spr_zumbi_morto;
		hp          = choose(3, 5, 7); // Zumbi comum
        velocidade  = 0.5;
        //estado      = "PARADO";
    break;
    
    // Se quiser um zumbi rápido no futuro, basta adicionar outro 'case' aqui!
}

// Inicializa o sprite correto
sprite_index = spr_parado;
image_speed = 0;


// Sistema de partículas individual do zumbi
part_sys = part_system_create();
part_sangue = part_type_create();

part_type_shape(part_sangue, pt_shape_disk); // Formato de círculo/pingo
part_type_size(part_sangue, 0.08, 0.1, -0.005, 0); // Começa médio e diminui
part_type_color1(part_sangue, c_red); // Sangue vermelho!
part_type_speed(part_sangue, 1.5, 3, -0.1, 0); // Velocidade do espirro
part_type_direction(part_sangue, 0, 360, 0, 10); // Espirra para todos os lados
part_type_life(part_sangue, 10, 25); // Dura meio segundo na tela


// Se ninguém disse qual é o estado, ele começa parado
if (!variable_instance_exists(id, "estado")) {
    estado = "PARADO";
}