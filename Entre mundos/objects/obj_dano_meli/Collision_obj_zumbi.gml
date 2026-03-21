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
        
        // 1. DEFINIR A DIREÇÃO: Pegamos a direção da bala (other)
    // Usamos part_type_direction para dizer ao sangue para onde ir antes de criá-lo
    var _dir_bala = other.direction;
    part_type_direction(part_sangue, _dir_bala - 25, _dir_bala + 25, 0, 0);

    // 2. CRIAR AS PARTÍCULAS:
	 // Cria 10 gotas de sangue na posição do tiro
        repeat(10) 
		{
			// Aumentamos para 25 como você colocou, e ajustamos a altura
			part_particles_create(part_sys, x, y - irandom_range(-15, 15), part_sangue, 1);
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