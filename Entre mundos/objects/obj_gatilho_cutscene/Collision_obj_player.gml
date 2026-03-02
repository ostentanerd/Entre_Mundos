// Se ainda não foi ativado
if (!ativado) {
    ativado = true;
    
    // Cria o diretor da cutscene
    if (!instance_exists(obj_cutscene_dialogo)) {
        instance_create_layer(0, 0, "Instances", obj_cutscene_dialogo);
    }
    
    // Destrói o gatilho para ele nunca mais rodar nesta fase
    instance_destroy(); 
}