camera_set_view_size(view_camera[0], global.view_width, global.view_height);

if (instance_exists(view_target))
{
	
	// 1. Criamos uma variável para o deslocamento suave se ela não existir
    if (!variable_instance_exists(id, "smooth_offset")) smooth_offset = 0;

    // 2. Em vez de mudar o offset na hora, fazemos ele deslizar devagar
    var _target_offset = view_target.face * 90; // Alvo final
    smooth_offset = lerp(smooth_offset, _target_offset, 0.05); // Suaviza a transição do olhar
	
	var x1    =  (view_target.x + smooth_offset)  -  global.view_width  /  2;
	var y1    =  view_target.y  -  global.view_height  /  0;
	
	
	x1        = clamp(x1, 0, room_width  -  global.view_width );
	y1        = clamp(y1, 0, room_height  - global.view_height);
	
	var c_x   = camera_get_view_x(view_camera[0]);
	var c_y   = camera_get_view_y(view_camera[0]);
	
	camera_set_view_pos(view_camera[0], lerp(c_x, x1, view_spd), lerp(c_y, y1, view_spd));
	
}	




