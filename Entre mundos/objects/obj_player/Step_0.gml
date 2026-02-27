/// --- INPUTS ---
var _key_left      = keyboard_check(ord("A"))  ||  keyboard_check(vk_left);
var _key_right     = keyboard_check(ord("D"))  ||  keyboard_check(vk_right);
var _key_up        = keyboard_check(ord("W"))  ||  keyboard_check(vk_up);
var _key_down      = keyboard_check(ord("S"))  ||  keyboard_check(vk_down);
var _key_jump      = keyboard_check_pressed(ord("J"));
var _key_interact  = keyboard_check_pressed(ord("E"));
var _key_flashlight = keyboard_check_pressed(ord("L"));
//var _mouse_click   = mouse_check_button(mb_left); // Click para animação de tiro




// 1. CHECAGEM DE MORTE (Coloque logo no início)
if (vida <= 0) {
    if (sprite_index != spr_player_morto) { // Substitua pelo nome do seu sprite de morte
        sprite_index = spr_player_morto;
        image_index = 0;
        image_speed = 1;
        
        // Destruir braços e lanterna para não ficarem flutuando sobre o corpo
        if (instance_exists(meus_bracos)) instance_destroy(meus_bracos);
        if (instance_exists(meu_lanterna)) instance_destroy(meu_lanterna);
        
        // Ativa o alarme para reiniciar (vimos antes)
        alarm[2] = 120;
		
		mask_index = -1; // <--- ADICIONE ISSO!
    
    // Isso remove a máscara de colisão. 
    // O player vira um "fantasma": o zumbi não consegue mais tocar nele.
    
    exit;

    }
    
    // Trava no último frame da animação de morte
    if (image_index >= image_number - 1) {
        image_speed = 0;
    }
    
    // Aplica gravidade para ele cair se morrer no ar
    if (!place_meeting(x, y + 1, obj_chao_normal)) {
        vsp += 0.3;
        // Colisão vertical simples para o corpo não atravessar o chão
        if (place_meeting(x, y + vsp, obj_chao_normal)) {
            while (!place_meeting(x, y + sign(vsp), obj_chao_normal)) y += sign(vsp);
            vsp = 0;
        }
        y += vsp;
    }

    exit; // PARA TUDO AQUI. O código abaixo não será lido se estiver morto.
}




if (brilho_tiro > 0) brilho_tiro -= 0.15; // Velocidade do clarão

//  ---- LÓGICA DA ESCADAS ----
if (place_meeting(x, y, obj_escada))
{
    if (_key_up || _key_down) no_escada = true;
}
else
{
    no_escada  = false;
}

if (no_escada)
{
    vsp        = (_key_down - _key_up) * vel_escada;
    hsp        = 0;
    grv        = 0;
}
else
{
    grv        = 0.3;
    var _move  = _key_right - _key_left;
    hsp        = _move * walksp;
    vsp       += grv;
    if (_move != 0) face = _move;
    
    if (place_meeting(x, y + 1, obj_chao_normal) && _key_jump) vsp = -jumpsp;
}


//  --- COLISÕES ---
// Colisão Horizontal
if (place_meeting(x + hsp, y, obj_chao_normal))
{
    while (!place_meeting(x + sign(hsp), y, obj_chao_normal)) 
    {
        x += sign(hsp);
    }
    hsp = 0;
}
x += hsp;

// Colisão Vertical
if (place_meeting(x, y + vsp, obj_chao_normal))
{
    while (!place_meeting(x, y + sign(vsp), obj_chao_normal)) 
    {
        y += sign(vsp);
    }
    vsp = 0;
}
y += vsp;


// ---- INTERAGIR (PEGAR ITENS)  ----
if (_key_interact) 
{
    // Procuramos o item exatamente onde o player está ou com uma pequena margem
    var _item = instance_place(x, y, obj_item_pai);
    
    if (_item != noone)
    {
        if (_item.tipo == "arma")
        {
			tem_pistola = true; // <--- AGORA ELE TEM A ARMA
			
            mao_atual = 1;
            municao += 10;
        }
        // Verifique esta linha abaixo:
        else if (_item.tipo == "municao") 
        {
            municao += _item.quantidade;
        }
		// --- ADICIONE ESTA PARTE PARA O CARTÃO ---
        else if (_item.tipo == "cartao") 
        {
            tem_cartao = true; 
            // Você pode adicionar uma mensagem no console para testar:
            show_debug_message("Pegou o Cartão Verde!");
        }
        
     // --- ADICIONE ESTA PARTE PARA O MEDKIT ---
        else if (_item.tipo == "medkit") 
        {
            medkits += 1; 
            show_debug_message("Pegou um Medkit!");
        }
        
        instance_destroy(_item);
    }
}





// --- ATUALIZAR ANIMAÇÕES DO CORPO (obj_player) ---
image_xscale = face; 

if (!place_meeting(x, y + 1, obj_chao_normal)) 
{
    // Se quiser um sprite de pulo, coloque aqui. Se não, deixe o de idle ou andando.
    // sprite_index = spr_player_pulo; 
} 
else 
{
    if (hsp != 0) sprite_index = spr_player_andando;
    else sprite_index = spr_player_idle;
}


// --- ATUALIZAR BRAÇOS E MÃOS ---
if (instance_exists(meus_bracos))
{
    meus_bracos.x = x;
    meus_bracos.y = y;
    meus_bracos.image_xscale = face;
    
    // Lista de sprites que NÃO devem ser interrompidos (tiro e facada)
    var _animando = (meus_bracos.sprite_index == spr_mao_pistola_atirando || meus_bracos.sprite_index == spr_mao_pistola_facada);

    if (!_animando) 
    {
        switch (mao_atual)
        {
            case 0: meus_bracos.sprite_index = spr_mao; break;
            case 1: 
			if (tem_pistola) meus_bracos.sprite_index = spr_mao_pistola;
			else meus_bracos.sprite_index = spr_mao; // Se não tem a arma, mostra a mão vazia
			break;
        }
    }
}

// --- LANTERNA ---
if (instance_exists(meu_lanterna)) 
{
    meu_lanterna.x = x;
    meu_lanterna.y = y - 11;
    // Opcional: Descomente abaixo se quiser que a luz siga o lado que o player olha
    // meu_lanterna.image_xscale = face; 
}




if (!pode_tomar_dano) {
    // Faz o sprite ficar meio transparente e voltar rapidamente
    image_alpha = sin(current_time * 0.1); 
} else {
    image_alpha = 1;
}





var _key_heal = keyboard_check_pressed(ord("U"));

if (_key_heal) 
{
    // 1. Verificamos se tem medkit
    if (medkits > 0) 
    {
        // 2. Verificamos se ele REALMENTE precisa de cura (vida menor que 10)
        // Substitua o '10' pela sua variável de vida máxima se você tiver uma
        if (vida < 5) 
        {
            medkits -= 1; // Gasta o item
            
            var _cura = irandom_range(2, 5); // Sorteia a cura entre 2 e 5
            vida += _cura; // Aplica a cura
            
            // Garante que não passe do limite máximo
            if (vida > 5) vida = 5; 
            
            show_debug_message("Curou " + string(_cura) + "! Vida atual: " + string(vida));
            
            // DICA: Você pode tocar um som de cura aqui
            // audio_play_sound(snd_cura, 1, false);
        }
        else 
        {
            // Opcional: Avisar que a vida já está cheia
            show_debug_message("Vida já está cheia! Medkit não utilizado.");
        }
    }
}