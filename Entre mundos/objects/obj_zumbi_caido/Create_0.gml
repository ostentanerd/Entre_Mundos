event_inherited(); // Puxa as variáveis do pai

// Evento CREATE do obj_zumbi_caido
event_inherited(); // 1º: Puxa as variáveis do pai

estado = E_ESTADO.PARADO;     // 2º: Força ele a começar PARADO (deitado)
spr_parado = spr_zumbi_caido; // 3º: Define que o "parado" dele é o sprite deitado

// Configuração dele:
spr_parado  = spr_zumbi_caido;   // Sprite dele parado DEITADO
spr_andando = spr_zumbi_andando;
spr_ataque  = spr_zumbi_atacando;
spr_morto   = spr_zumbi_morto;

estado = E_ESTADO.PARADO; // Ele começa deitado e só levanta se o player chegar perto!
hp = 2; // Menos vida por estar vulnerável

