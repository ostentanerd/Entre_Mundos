draw_self(); // Desenha a gaveta

if (!quebrada && distance_to_object(obj_player) < 20) {
    draw_set_font(fnt_itens);
    draw_set_halign(fa_center);
    //draw_text(x, y - 30, "[E]");
}