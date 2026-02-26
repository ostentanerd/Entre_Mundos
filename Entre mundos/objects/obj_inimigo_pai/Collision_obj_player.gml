

// Evento de Colisão do obj_inimigo_pai com obj_player

// Verificamos se o inimigo está vivo
if (hp <= 0) exit; 
if (estado == ESTADO_NORMAL.MORTO) exit;

// O 'other' aqui é o PLAYER que colidiu com o zumbi
if (instance_exists(other)) 
{
    // ADICIONE "other." antes de pode_tomar_dano e das outras variáveis do player
    if (other.pode_tomar_dano) 
    {
        other.vida -= 1;
        other.pode_tomar_dano = false;
        other.invulneravel = true;
        other.flash_player = 1; // Ativa o brilho vermelho no Draw do player
        
        // --- LÓGICA DO PULO PARA TRÁS (Knockback) ---
        var _dir = sign(other.x - x); 
        if (_dir == 0) _dir = -other.face;
        
        other.hsp = _dir * 5;  // Empurra o player
        other.vsp = -2;        // Faz o player pular
        
        // Ativa o alarme NO PLAYER para ele voltar a poder tomar dano
        other.alarm[1] = 60; 
    }
}