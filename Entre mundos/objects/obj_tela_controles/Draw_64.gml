// --- 1. SEGURANÇA E ESCALA (REDUZIDA PARA 2) ---
if (!variable_global_exists("hud_escala")) global.hud_escala = 3;

display_set_gui_size(window_get_width(), window_get_height());

// Usamos escala 2 para o texto não ficar gigante
var _escala_texto = 2; 
var _m = matrix_build(0, 0, 0, 0, 0, 0, _escala_texto, _escala_texto, 1);
matrix_set(matrix_world, _m);

// --- 2. POSIÇÃO INICIAL (Margem esquerda) ---
var _x_origem = 50; 
var _y_origem = 30;

// --- 3. DESENHO DOS TEXTOS (ALINHADO À ESQUERDA) ---
draw_set_halign(fa_left);
draw_set_valign(fa_top);

// Título
draw_set_font(fnt_missao);
draw_set_color(c_red);
draw_text(_x_origem +50, _y_origem, "DIRETRIZES DE MISSÃO: AGENTE ZERO");

// Corpo dos Controles
draw_set_font(fnt_dialogo);
draw_set_color(c_white);



// --- DESENHANDO EM DUAS COLUNAS ---
var _x_teclas = _x_origem + 220; // Ajuste este valor para a direita

draw_set_color(c_white);
// Coluna 1: Nomes das ações
draw_text(_x_origem + 150, _y_origem + 60, "MOVIMENTAÇÃO\nFACADA\nTIRO\nKIT MÉDIC0\nLANTERNA\nINTERAGIR");

// Coluna 2: Teclas (em AMARELO para destacar)
draw_set_color(c_yellow);
draw_text(_x_teclas  - 165, _y_origem + 60, "[A][D]\n[ I ]\n[K]\n[U]\n[L]\n[E]");

// --- 4. PRESSIONE ESPAÇO ---
if (pode_sair) {
    var _alpha = abs(sin(get_timer() / 250000)); 
    draw_set_alpha(_alpha);
    draw_set_color(c_yellow);
    draw_text(_x_origem + 80, _y_origem + 280, ">> PRESSIONE [ENTER] PARA INICIAR");
    draw_set_alpha(1);
}

// --- 5. RESET ---
matrix_set(matrix_world, matrix_build_identity());
draw_set_color(c_white);