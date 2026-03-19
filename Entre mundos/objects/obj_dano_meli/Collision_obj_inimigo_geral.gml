// Evento Collision com obj_inimigo_geral
if (instance_exists(other)) 
{
    // 1. SÓ ACERTA SE O INIMIGO ESTIVER VIVO
    if (other.hp > 0) 
    {
        // Tira o dano
        other.hp -= dano;
        
        // Feedback no console
        show_debug_message("Inimigo atingido! HP restante: " + string(other.hp));
        
        // Feedback visual
        other.flash = 1;
        
        // --- SISTEMA DE SANGUE ---
        // Pegamos a direção baseada na face do player para o sangue voar certo
        var _dir = (obj_player.image_xscale == 1) ? 0 : 180; 
        part_type_direction(other.part_sangue, _dir - 25, _dir + 25, 0, 0); 
        // Cria 10 gotas de sangue na posição do tiro
        repeat(10) 
		{
        // Criamos as partículas na posição do inimigo
			part_particles_create(other.part_sys, x, y - irandom_range(-10, 10), other.part_sangue, 1);
		}
		
        // A faca some ao atingir um alvo vivo
        instance_destroy();
    }
    else 
    {
        // Se o inimigo já estiver morto, não fazemos nada.
        // A faca vai continuar existindo por aqueles 5 frames e 
        // poderá atingir outro zumbi vivo que esteja atrás dele!
        exit;
    }
}