// --- No ALARM 2 do obj_player ---

// 1. Recuperar itens (Mochila recebe o Cofre)
global.medkits = global.save_medkits;
global.municao = global.save_municao;
global.vida = 5;

// 2. Definir o destino COM SEGURANÇA
var _alvo = rm_fase_1; // Defina aqui o nome da sua primeira sala real

// Se o player já usou um computador, o alvo vira a sala do save
if (global.checkpoint_room != noone && room_exists(global.checkpoint_room)) {
    _alvo = global.checkpoint_room;
}

// 3. Criar a transição e PASSAR o destino
var _tran = instance_create_layer(0, 0, "Instances", obj_transicao);
_tran.destino = _alvo; // Aqui você entrega o valor para o obj_transicao
_tran.estado = 1;
_tran.velocidade = 0.02;