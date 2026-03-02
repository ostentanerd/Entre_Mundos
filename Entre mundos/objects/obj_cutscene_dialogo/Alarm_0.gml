// --- Alarm 0 do obj_cutscene_dialogo ---
caractere_atual = 0; // Reseta a digitação para a nova frase
passo += 1;

switch(passo) {
    case 1:
        texto_exibir = "Droga... a porta do setor 4 está selada.";
        break;
    case 2:
        texto_exibir = "Se eu não encontrar aquele cartão de acesso rápido, ficarei preso aqui com... SEJA LÁ O QUE FOR AQUILO.";
        break;
    case 3:
        texto_exibir = "Preciso checar os terminais de save. Eles podem ter informações sobre o paradeiro da equipe.";
        break;
    case 4:
        global.cutscene = false; // Devolve o controle ao player
        instance_destroy();      // Fim da cena
        break;
}