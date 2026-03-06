if (criados < quantidade_inimigos) {
    spawn_timer--; 

    if (spawn_timer <= 0) {
        // 1. CÁLCULO DE POSIÇÃO (Igual ao que você já tinha)
        var _lado = choose(-1, 1);
        var _distancia = 400; 
        var _spawn_x = obj_player.x + (_lado * _distancia);
        _spawn_x = clamp(_spawn_x, -5, 2375); // Garante que não nasça fora do mapa
        var _spawn_y = 109; 

        // 2. DEFINIR QUAL TIPO VAI NASCER NESSA FASE
        var _tipo_escolhido = "normal"; // Começa como normal por padrão

        // Aqui você decide o que nasce em cada sala
        if (room == rm_fase_1) {
            _tipo_escolhido = "caido";  // Na fase 1, só zumbis deitados
        } 
        else if (room == rm_fase_2) {
            _tipo_escolhido = choose("normal", "PATRULHANDO"); // Na fase 2, misturado!
        }

        // 3. A MÁGICA: Criar o inimigo enviando o tipo dele
        // Esse { tipo_inimigo : _tipo_escolhido } é o que define o zumbi!
        var _zumbi = instance_create_layer(_spawn_x, _spawn_y, "Inimigo", obj_inimigo_geral, 
        {
            tipo_inimigo: _tipo_escolhido,
			meu_spawner:  id,
			estado:      "PATRULHANDO", // <--- Define o estado aqui
			ponto_a:     _spawn_x - 100, // Ponto esquerda
			ponto_b:     _spawn_x + 100, // Ponto direita
			destino_x:   _spawn_x + 100  // Começa indo para a direita
        });
        
        // 4. FINALIZAÇÃO
        _zumbi.meu_spawner = id; 
        criados++;
        spawn_timer = 360; // Tempo até o próximo (6 segundos a 60fps)
    }
}