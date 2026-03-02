// --- 1. RESET DE INTERFACE PARA ESTA BARRA ---
// Isso garante que o código abaixo ignore qualquer "zoom" vindo de outros objetos
matrix_set(matrix_world, matrix_build_identity());

var _w_tela = window_get_width();
var _h_tela = window_get_height();

// Define o tamanho da GUI para o tamanho real da janela (Nitidez máxima)
display_set_gui_size(_w_tela, _h_tela);

// --- 2. CONFIGURAÇÃO DE POSIÇÃO (Ajuste esses valores se quiser mover) ---
// Em vez de 285 fixo, vamos usar 20% da largura da tela
var _x_base = _w_tela * 0.15; 
var _y_base = _h_tela -690; // Fica a 80 pixels do fundo, não importa a fase

// --- 3. DESENHA O ÍCONE (Escala fixa para não crescer) ---
var _escala_icone = 1.5; 
draw_sprite_ext(spr_lanterna_hud, 0, _x_base, _y_base + 10, _escala_icone, _escala_icone, 0, c_white, 1);

// --- 4. CONFIGURAÇÃO DA BARRA ---
var _x_barra = _x_base + 40;
var _y_barra = _y_base; 
var _largura_max = 200; // Tamanho fixo em pixels reais
var _altura_barra = 15;

// Fundo Preto
draw_set_color(c_black);
draw_rectangle(_x_barra - 2, _y_barra - 2, _x_barra + _largura_max + 2, _y_barra + _altura_barra + 2, false);

// Lógica de Carga
var _porcentagem = (carga_atual / carga_maxima);
var _cor_bateria = (_porcentagem < 0.3) ? c_red : c_lime;

// Desenha a Carga
draw_set_color(_cor_bateria);
draw_rectangle(_x_barra, _y_barra, _x_barra + (_largura_max * _porcentagem), _y_barra + _altura_barra, false);

// Reset de cor
draw_set_color(c_white);