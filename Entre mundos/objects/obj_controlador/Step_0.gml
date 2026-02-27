if (criados < quantidade_inimigos) {
    spawn_timer--;

    if (spawn_timer <= 0) {
        // 1. Define a distância do player (frente ou trás)
        var _lado = choose(-1, 1);
        var _distancia = 400; 
        var _spawn_x = obj_player.x + (_lado * _distancia);

        // 2. A MÁGICA: Limita o X para ficar entre 10 e 1334
        // Se o cálculo der menos que 10, ele vira 10. Se der mais que 1334, vira 1334.
        _spawn_x = clamp(_spawn_x, -5, 1365);
        
        // 3. Define o Y exato que você pediu
        var _spawn_y = 109; 

        // 4. Cria o zumbi na layer "Inimigo"
        var _zumbi = instance_create_layer(_spawn_x, _spawn_y, "Inimigo", obj_zumbi);
        
        _zumbi.meu_spawner = id; 
        
        criados++;
        spawn_timer = 180; 
    }
}
if (aviso_timer > 0) aviso_timer -= 1;