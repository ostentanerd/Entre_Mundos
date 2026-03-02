// 1. Barras de Cinema
draw_set_color(c_black);
draw_rectangle(0, 0, display_get_gui_width(), 80, false); 
draw_rectangle(0, display_get_gui_height() - 100, display_get_gui_width(), display_get_gui_height(), false); 

// 2. Efeito Digitação
if (caractere_atual < string_length(texto_exibir)) {
    caractere_atual += 0.5; 
}
var _txt = string_copy(texto_exibir, 1, floor(caractere_atual));

// 3. Desenhar NOME (Quem fala)
draw_set_font(fnt_missao); // Uma fonte um pouco mais séria
draw_set_color(c_yellow);  // Nome em destaque
draw_set_halign(fa_left);
draw_text(50, display_get_gui_height() - 140, nome_exibir + ":");

// 4. Desenhar FALA
draw_set_font(fnt_dialogo);
draw_set_color(c_white);
draw_set_halign(fa_center);
// Desenha o texto centralizado na barra de baixo
draw_text_ext(display_get_gui_width() / 2, display_get_gui_height() - 105, _txt, 28, display_get_gui_width() - 100);