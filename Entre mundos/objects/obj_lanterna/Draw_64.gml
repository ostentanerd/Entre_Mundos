// --- CONFIGURAÇÃO DE POSIÇÃO ---
var _x_base = 10;   // Onde o ícone começa
var _y_base = 125;  // Altura geral da HUD da lanterna
var _espaco_icone = 7; // Espaço que o ícone ocupa antes da barra

// 1. DESENHA O ÍCONE DA LANTERNA
// Usamos draw_sprite_ext para diminuir o tamanho se o seu sprite for muito grande
draw_sprite_ext(spr_lanterna_hud, 0, _x_base, _y_base + 5, 0.5, 0.5, 0, c_white, 1);

// --- CONFIGURAÇÃO DA BARRA (Ajustada para ficar ao lado do ícone) ---
var _x_barra = _x_base + _espaco_icone;
var _y_barra = _y_base + 1;
var _largura_max = 50;
var _altura_barra = 5;

// 2. FUNDO DA BARRA (PRETO)
draw_set_color(c_black);
draw_rectangle(_x_barra - 1, _y_barra - 1, _x_barra + _largura_max + 1, _y_barra + _altura_barra + 1, false);

// 3. LÓGICA DE COR E CARGA
var _cor_bateria = c_lime;
if (carga_atual < 30) _cor_bateria = c_red;

// Cálculo para a barra não passar do tamanho máximo
// Fórmula: (Carga Atual / Carga Máxima) * Largura Total
var _porcentagem = (carga_atual / carga_maxima);
var _largura_preenchida = _porcentagem * _largura_max;

// 4. DESENHA A CARGA
draw_set_color(_cor_bateria);
draw_rectangle(_x_barra, _y_barra, _x_barra + _largura_preenchida, _y_barra + _altura_barra, false);

// Resetar para branco
draw_set_color(c_white);