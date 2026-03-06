// Pega o tamanho real da janela para o texto ficar nítido
var _largura = window_get_width();
var _altura = window_get_height();
display_set_gui_size(_largura, _altura);


// --- SISTEMA DE BATERIA ---
carga_maxima = 50;     // Bateria cheia
carga_atual = 50;      // Bateria no momento
taxa_gasto = 0.1;       // Quanto gasta por frame (diminuir para durar mais)
taxa_recarga = 0.05;     // Quanto recupera por frame (lanterna desligada)
tempo_bloqueio = false; // Impede ligar se a bateria estiver muito baixa

global.hud_escala = 3;





// --- FIM DA ESCALA DA HUD ---
// Reseta a escala para não afetar outras coisas (como o mouse ou filtros)
matrix_set(matrix_world, matrix_build_identity());