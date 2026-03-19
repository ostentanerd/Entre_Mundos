// Ler teclas
var _cima = keyboard_check_pressed(vk_up) || keyboard_check_pressed(ord("W"));
var _baixo = keyboard_check_pressed(vk_down) || keyboard_check_pressed(ord("S"));;
var _entrar = keyboard_check_pressed(vk_enter);

// Mudar seleção
index += _baixo - _cima;

// Loop do menu (se estiver no fim, volta para o topo)
if (index >= op_max) index = 0;
if (index < 0) index = op_max - 1;

// Ação ao apertar Enter
if (_entrar) {
    switch (index) {
        case 0: // INICIAR JOGO
		
		    // Reseta tudo para o padrão de um jogo novo
            global.municao = 10;
            global.save_municao = 10;
            global.tem_lanterna = false;
            global.save_tem_lanterna = false;
            global.checkpoint_room = noone;
			
            // Se o objeto de transição não existir, cria ele
        if (!instance_exists(obj_transicao)) {
            var _trans = instance_create_depth(0, 0, -9999, obj_transicao);
            
            // MUDE "rm_fase_1" para o nome EXATO da sua primeira fase
            _trans.destino = rm_fase_1; 
            _trans.estado = 1;
            _trans.velocidade = 0.02;
        }
            break;
            
        case 1: // OPÇÕES (Futuro)
            room_goto(rm_controles);
            break;
            
        case 2: // SAIR
            game_end();
            break;
    }
}