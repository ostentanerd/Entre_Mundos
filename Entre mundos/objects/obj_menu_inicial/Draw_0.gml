// --- Evento DRAW do obj_menu ---
// Pega o tamanho real da janela para o texto ficar nítido
var _largura = window_get_width();
var _altura = window_get_height();
display_set_gui_size(_largura, _altura); 



// 1. Configurações de alinhamento
draw_set_halign(fa_center);
draw_set_valign(fa_middle);
draw_set_font(fnt_menu); 

// 2. Definir o centro da tela (para não depender da posição do objeto na sala)
var _meio_x = room_width / 2;
var _meio_y = room_height / 2;

// 3. Desenhar as opções
for (var i = 0; i < op_max; i++) {
    var _cor = c_white;
    var _escala = 1.5;
    var _espacamento = 60; // Aumente este número se as opções estiverem muito juntas
    
    // Se for a opção selecionada
    if (index == i) {
        _cor = c_yellow;
        _escala = 3; // Aumenta o tamanho da opção selecionada
        draw_text(_meio_x - 140, _meio_y + (i * _espacamento), ">>"); 
    }
    
    // Desenha o texto centralizado
    draw_text_transformed_color(_meio_x, _meio_y + (i * _espacamento), opcoes[i], _escala, _escala, 0, _cor, _cor, _cor, _cor, 1);
}

var _largura = window_get_width();
var _altura = window_get_height();
display_set_gui_size(_largura, _altura);












// --- FIM DA ESCALA DA HUD ---
// Reseta a escala para não afetar outras coisas (como o mouse ou filtros)
matrix_set(matrix_world, matrix_build_identity());