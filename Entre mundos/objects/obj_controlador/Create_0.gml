// No Create do obj_controlador

global.checkpoint_x = 0;
global.checkpoint_y = 0;


surf = -1;

aviso_timer = 0;
fade_alpha = 0;

global.vida = 5;


global.pode_spawnar = false; // Começa falso para a Fase 1 ser segura

texto_titulo_timer = 0; // Começa em zero
global.pode_mover = true;
// No Create do obj_controlador
global.tem_pistola = false;
global.tem_lanterna = false;
global.luz_acesa = false;




global.medkits = 0;        
global.save_medkits = 0;   
global.municao = 0;
global.save_municao = 0;
global.checkpoint_room = noone;
global.save_bloqueado = false;





global.tem_cartao = false;
// Adicione aqui qualquer outro item do inventário
global.meu_lanterna = noone; // <--- Adicione isso por segurança para o erro sumi
global.save_tem_lanterna = false;


global.lanterna_carga = 50; // Começa com 100%
global.lanterna_max   = 50;




// Variáveis de BACKUP (o que será carregado ao morrer)
global.save_vida = 5;



global.cutscene = false;


global.hud_escala = 4;

/*
// Configuração da Horda
quantidade_inimigos = 20; // Total que vai nascer
criados = 0;              // Quantos já nasceram
vivos = 20;               // Quantos ainda estão no mapa (usado para o cartão)
spawn_timer = 120;        // Tempo entre um zumbi e outro
*/