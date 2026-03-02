if (alpha > 0) {
    draw_set_alpha(alpha);
    draw_set_color(c_black);
    
    // Desenha em toda a tela da interface
    draw_rectangle(0, 0, display_get_gui_width(), display_get_gui_height(), false);
    
    // Reseta para não afetar outros desenhos
    draw_set_alpha(1);
    draw_set_color(c_white);
}