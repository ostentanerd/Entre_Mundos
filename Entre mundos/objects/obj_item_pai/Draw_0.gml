// 1. Primeiro, o item precisa desenhar a si mesmo (o sprite do item no chão)
draw_self();



if (instance_exists(obj_player)) {
    var _dist = point_distance(x, y, obj_player.x, obj_player.y);
    
    if (_dist < 45) {
        // 1. DIZEMOS AO JOGO PARA USAR A SUA FONTE
        draw_set_font(fnt_itens); 
        
        draw_set_halign(fa_center);
        draw_set_valign(fa_bottom);
        draw_set_color(c_white);
        
        // 2. DESENHAMOS O TEXTO
        draw_text(x, y - 9, "[E]");
        
        // 3. SEMPRE VOLTE PARA A FONTE PADRÃO (ou -1) 
        // Isso evita que o jogo inteiro use a fonte de itens sem querer
        draw_set_font(-1); 
        
        draw_set_halign(fa_left);
        draw_set_valign(fa_top);
    }
}