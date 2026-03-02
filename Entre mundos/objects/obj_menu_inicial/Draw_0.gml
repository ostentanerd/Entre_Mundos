// --- Evento DRAW do obj_menu ---

// 1. Configurações de alinhamento
draw_set_halign(fa_center);
draw_set_valign(fa_middle);

// 2. Definir o centro da tela (para não depender da posição do objeto na sala)
var _meio_x = room_width / 2;
var _meio_y = room_height / 2;

// 3. Desenhar as opções
for (var i = 0; i < op_max; i++) {
    var _cor = c_white;
    var _escala = 1;
    var _espacamento = 60; // Aumente este número se as opções estiverem muito juntas
    
    // Se for a opção selecionada
    if (index == i) {
        _cor = c_yellow;
        _escala = 1.5; // Aumenta o tamanho da opção selecionada
        draw_text(_meio_x - 120, _meio_y + (i * _espacamento), ">>"); 
    }
    
    // Desenha o texto centralizado
    draw_text_transformed_color(_meio_x, _meio_y + (i * _espacamento), opcoes[i], _escala, _escala, 0, _cor, _cor, _cor, _cor, 1);
}