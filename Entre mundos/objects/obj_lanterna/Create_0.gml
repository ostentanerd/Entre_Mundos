// --- SISTEMA DE BATERIA ---
carga_maxima = 50;     // Bateria cheia
carga_atual = 50;      // Bateria no momento
taxa_gasto = 0.1;       // Quanto gasta por frame (diminuir para durar mais)
taxa_recarga = 0.05;     // Quanto recupera por frame (lanterna desligada)
tempo_bloqueio = false; // Impede ligar se a bateria estiver muito baixa

global.hud_escala = 3;

x_offset = 0; // Se quiser que a luz saia mais para a direita, aumente esse número
y_offset = -10; // Ajusta a altura da lanterna (número negativo sobe)
