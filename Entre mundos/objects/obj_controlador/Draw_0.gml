// 1. Verificamos se o player existe para saber onde desenhar as luzes
if (!instance_exists(obj_player)) exit;

// 2. Pegamos as informações da câmera e do player
var _cx = camera_get_view_x(view_camera[0]);
var _cy = camera_get_view_y(view_camera[0]);
var _cw = global.view_width;
var _ch = global.view_height;

var _px = obj_player.x;
var _py = obj_player.y;
var _face = obj_player.face;

// 3. Criar/Validar a superfície
if (!surface_exists(surf)) {
    surf = surface_create(_cw, _ch);
}

// 4. Desenhar na superfície
surface_set_target(surf);

    // Pinta a tela toda de preto
    draw_clear_alpha(c_black, 0.69); 

    // Ativa o modo de "furar" o preto
    gpu_set_blendmode(bm_subtract);

    // --- LUZ DA LANTERNA ---
    if (obj_player.lanterna_ligada) {
        // Desenhamos a luz na posição do player (ajustada para a surface)
        draw_sprite_ext(spr_luz_suave, 0, _px - _cx, (_py - 10) - _cy, 2.5, 2.5, 0, c_white, 1);
    }
	
	// --- LUZ DAS VELAS (ADICIONADO) ---
    // O 'with' faz o código rodar para TODAS as velas da sala ao mesmo tempo
    with (obj_vela) {
        // Criamos um efeito de oscilação (opcional)
        var _oscilacao = choose(2, 2.5, 1.0); 
        
        // Desenhamos a luz da vela. 
        // Importante: usamos x - _cx para alinhar com a câmera
        draw_sprite_ext(spr_luz_suave, 0, x - _cx, (y - 15) - _cy, _oscilacao, _oscilacao, 0, c_white, 0.8);
    }
	
	

// --- CLARÃO DO TIRO ---
  if (obj_player.brilho_tiro > 0) {
    var _dist_cano = 22 * _face;
    var _bt = obj_player.brilho_tiro;
    var _ajuste_altura = 20; 
    
    // Criamos a escala da luz. 
    // Multiplicamos o tamanho (_bt * 2) pela direção (_face)
    var _escala_x = (_bt * 2) * _face;
    var _escala_y = (_bt * 2);
    
    draw_sprite_ext(spr_luz_arma, 0, (_px + _dist_cano) - _cx, (_py - _ajuste_altura) - _cy, _escala_x, _escala_y, 0, c_white, 1);
  }

    gpu_set_blendmode(bm_normal);

surface_reset_target();

// 5. DESENHA A "MÁSCARA" PRETA SOBRE O JOGO
draw_surface(surf, _cx, _cy);