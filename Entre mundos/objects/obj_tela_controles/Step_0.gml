// Verifica se o tempo de espera do Alarm 0 já passou
if (pode_sair) {
    if (keyboard_check_pressed(vk_space)) {
        
        // Se o objeto de transição não existir, cria ele
        if (!instance_exists(obj_transicao)) {
            var _tran = instance_create_depth(0, 0, -9999, obj_transicao);
            
            // MUDE "rm_fase_1" para o nome EXATO da sua primeira fase
            _tran.destino = rm_fase_1; 
            _tran.estado = 1;
            _tran.velocidade = 0.02;
        }
    }
}