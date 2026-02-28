draw_set_font(fnt_itens);
draw_set_halign(fa_center);
draw_set_color(c_white);

// Desenha o [E] na posição atual do objeto
draw_text(x, y, "[E]");

// Resetar para não bugar outros desenhos
draw_set_halign(fa_left);