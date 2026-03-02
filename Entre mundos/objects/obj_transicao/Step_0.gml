// Faz o alpha subir ou descer baseado no estado
alpha += (velocidade * estado);

// FASE 1: A tela ficou totalmente preta
// No Step do obj_transicao
if (alpha >= 1 && estado == 1) {
    alpha = 1;
    estado = -1; 
    
    // VERIFIQUE ESTA LINHA:
    if (destino != noone && room_exists(destino)) {
        room_goto(destino);
    }
}

// FASE 2: A tela clareou totalmente na sala nova
if (alpha <= 0 && estado == -1) {
    instance_destroy(); // O objeto se deleta e limpa a memória
	global.pode_mover = true;
}