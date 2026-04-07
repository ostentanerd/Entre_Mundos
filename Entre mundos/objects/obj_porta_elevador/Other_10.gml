/// @description Interação do Elevador

// 1. Só interage se a LUZ estiver acesa e a porta FECHADA
if (global.luz_acesa && !aberta) 
{
    // 2. Se o player TEM o cartão
    if (global.tem_cartao) 
    {
        aberta = true;
        global.tem_cartao = false; // Gasta o cartão (opcional)
        
        sprite_index = spr_porta_abrindo;
        image_index = 0;
        image_speed = 0.35;
        show_debug_message("Abrindo Elevador...");
    } 
    // 3. Se o player NÃO TEM o cartão
    else 
    {
        if (instance_exists(obj_controlador)) 
        {
            obj_controlador.aviso_timer = 90; // Ativa o texto na GUI
            show_debug_message("Aviso enviado ao controlador!");
        }
		// FAZ A CÂMERA TREMER UM POUQUINHO (Feedback de erro)
		if (instance_exists(obj_camera)) {
		    obj_camera.shake_power = 2; // Um tremor leve
		    obj_camera.shake_decay = 0.2;
		}
    }
	
}