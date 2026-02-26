resolution_width    =  1280;
resolution_height   =  720;
resolution_scale    =  4;
global.view_width   =  resolution_width / resolution_scale;
global.view_height  =  resolution_height / resolution_scale;

view_target         =  obj_player;

view_spd            =  0.1;

window_set_size(global.view_width * resolution_scale, global.view_height * resolution_scale);
surface_resize(application_surface, global.view_width * resolution_scale, global.view_height * resolution_scale )

display_set_gui_size(global.view_width, global.view_height);


// Variáveis de controle do tremor
shake_intensidade = 0; // O quanto a tela treme agora
shake_decai = 0.1;     // O quão rápido o tremor para (0.1 é suave, 0.5 é brusco)

// Evento Create do obj_camera
shake_power = 0;  // Começa em zero para não tremer parado
shake_decay = 0.2; // Velocidade com que o tremor para