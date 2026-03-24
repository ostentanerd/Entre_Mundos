// --- EVENTO ROOM START do obj_controlador ---

// 1. CHECAGEM DO MENU: Se voltou pro menu, reseta tudo do zero
if (room == rm_menu) {
    global.checkpoint_room = noone; 
    global.save_bloqueado = false;
    global.tem_lanterna = false;
    exit; // Para o código aqui se for o menu
}

// 2. LÓGICA DO BLOQUEIO DO COMPUTADOR:
// Se a sala que entrei é diferente da sala onde eu salvei no PC...
if (room != global.checkpoint_room) 
{
    global.save_bloqueado = false; // Libera o computador da nova fase
}
else 
{
    // Se eu morri e voltei para a mesma sala do PC, 
    // mantenho o bloqueio para não salvar duas vezes.
    if (global.checkpoint_room != noone) {
        global.save_bloqueado = true;
    }
}

// 3. BACKUP DE SEGURANÇA (Opcional):
// Isso salva a posição do player assim que ele entra na sala, 
// caso ele morra antes de chegar em um computador de save.
if (room != rm_menu) { 
    // APENAS se ainda não houver um checkpoint salvo nesta sala, 
    // nós guardamos a posição inicial de entrada.
    if (global.checkpoint_room != room) {
        if (instance_exists(obj_player)) {
            global.checkpoint_x = obj_player.x;
            global.checkpoint_y = obj_player.y;
        }
    }
}


// 1. Primeiro, paramos qualquer música que esteja tocando antes
audio_stop_all();

// 2. Agora, perguntamos ao jogo: "Em qual sala eu estou?"
// E dependendo da sala, tocamos a música certa
switch (room) 
{
    case rm_fase_1: // Troque pelo nome real da sua Room no Asset Browser
       // No Room Start, após o audio_play_sound:
		var _musica_atual = audio_play_sound(snd_musica_save, 10, true);
		audio_sound_gain(_musica_atual, 0, 0);          // Começa no volume 0
		audio_sound_gain(_musica_atual, 0.5, 2000);     // Sobe para 0.5 em 2 segundos (2000ms)

    case rm_fase_2:
        var _musica_atuall = audio_play_sound(snd_musica_fase2, 10, true);
		audio_sound_gain(_musica_atuall, 0, 0);          // Começa no volume 0
		audio_sound_gain(_musica_atuall, 0.5, 2000);     // Sobe para 0.5 em 2 segundos (2000ms)
        break;

    case rm_fase_boss:
        audio_play_sound(snd_musica_boss, 15, true); // Prioridade maior para o Boss!
        break;
        
    default:
        // Se for uma sala que não listamos (tipo um Menu), toca uma padrão ou nada
        // audio_play_sound(snd_musica_menu, 10, true);
        break;
}