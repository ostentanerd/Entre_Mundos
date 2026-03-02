// Ler teclas
var _cima = keyboard_check_pressed(vk_up);
var _baixo = keyboard_check_pressed(vk_down);
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
			
            room_goto(rm_controles); 
            break;
            
        case 1: // OPÇÕES (Futuro)
            show_message("Menu de Opções em breve!");
            break;
            
        case 2: // SAIR
            game_end();
            break;
    }
}