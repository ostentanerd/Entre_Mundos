draw_self(); // Desenha o sprite do computador

// Se o timer estiver ativo, mostra a mensagem
if (timer_texto > 0) {
    draw_set_font(fnt_itens); 
    draw_set_halign(fa_center);
    
    // Faz o texto subir devagarinho enquanto some
    var _efeito_subir = (90 - timer_texto) * 0.2; 
    
    // Cor piscante verde/branco
    var _cor = (current_time % 200 < 100) ? c_lime : c_white;

    // Sombra preta
    draw_text_color(x, y - 30 - _efeito_subir, "SISTEMA SINCRONIZADO", c_black, c_black, c_black, c_black, 1);
    // Texto principal
    draw_text_color(x - 1, y - 31 - _efeito_subir, "SISTEMA SINCRONIZADO", _cor, _cor, _cor, _cor, 1);
    
    // Reseta o alinhamento para não bugar outros textos
    draw_set_halign(fa_left);
}