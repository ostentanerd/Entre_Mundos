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