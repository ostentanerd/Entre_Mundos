if (keyboard_check_pressed(vk_space) || keyboard_check_pressed(ord("E"))) {
    if (caractere_atual < string_length(texto_exibir)) {
        caractere_atual = string_length(texto_exibir);
    } 
    else {
        if (passo < total_passos) {
            passo += 1;
            texto_exibir = fala[passo];
            nome_exibir = quem[passo]; // Atualiza o nome de quem fala
            caractere_atual = 0;
        } 
        else {
            global.cutscene = false;
            instance_destroy();
        }
    }
}