event_inherited();
// Só toma dano se NÃO estiver no estado MORTO
if (estado != ESTADO_NORMAL.MORTO) {
    hp -= 1;
    
    // 1. DEFINIR A DIREÇÃO: Pegamos a direção da bala (other)
    // Usamos part_type_direction para dizer ao sangue para onde ir antes de criá-lo
    var _dir_bala = other.direction;
    part_type_direction(global.part_sangue, _dir_bala - 25, _dir_bala + 25, 0, 0);

    // 2. CRIAR AS PARTÍCULAS:
    // Aumentamos para 25 como você colocou, e ajustamos a altura
    part_particles_create(global.part_sistema, x, y - irandom_range(-15, 15) , global.part_sangue, 25);
    
    flash = 3; 

    // O tiro morre ao bater no zumbi vivo
    with(other) {
        instance_destroy();
    }
}
else 
{
    // Opcional: O tiro atravessa o zumbi se ele já estiver morto
    // Se quiser que o tiro suma mesmo assim, apague esse "else"
}