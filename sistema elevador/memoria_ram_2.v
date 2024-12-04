// modulo responsavel pela memoria ram

module memoria_ram_2(andar_atual, andar_pessoa, andar_chamada, subir_pessoa, botao_chamada, movimento_elevador, indicador_porta_aberta, clock_in, leitura_endereco, proximo_andar, porta_fechada, quantidade_pessoas_dentro);
 input [1:0] andar_atual;
 input [1:0] andar_pessoa;
 input [1:0] andar_chamada;
 input [1:0] quantidade_pessoas_dentro;
 input porta_fechada;
 input subir_pessoa, botao_chamada, movimento_elevador, indicador_porta_aberta, clock_in;
 output  leitura_endereco;
 output [1:0] proximo_andar;
 
 wire [1:0] andar_para_registrar;
 wire andar_visitado, leitura_dados_endereco_fornecido, andar_iguais,numero_tres, pessoas_registrar_andar;
 wire [1:0] andar_pessoa_com_permissao;
 
 // nao eh permitido a escrita de dados das pessoas caso esteja na capacidade maxima
 // ou a porta esteja fechada
 
 and And_numero_tres(numero_tres, quantidade_pessoas_dentro[1], quantidade_pessoas_dentro[0]);
 or or_Permitir_pessoas_registrar_andar(pessoas_registrar_andar, numero_tres, porta_fechada);
 
 mux_2x1_2bits Seletor_permissao_pessoa_no_andar(andar_pessoa, andar_atual, pessoas_registrar_andar, andar_pessoa_com_permissao);
 
 // marcando o andar atual como visitado na memoria
 marcar_andar_como_visitado verifica_andar(leitura_dados_endereco_fornecido, indicador_porta_aberta, andar_iguais, clock_in, andar_visitado);

// selecionando se vai gravar o andar da chamada ou da pessoa 
 mux_2x1_2bits seletor_andar_gravar(andar_chamada, andar_pessoa_com_permissao, subir_pessoa, andar_para_registrar); 
 
 // comparando o andar que vai ser registrado, com o atual
 // caso seja igual a memoria nao registra, ja que eh o mesmo andar
 wire maior, menor;
 
 comparador comparar_andar_registrar_com_atual(maior, menor, andar_para_registrar, andar_atual);
 nor Nor0(andar_iguais, maior, menor);
 
 // controles da memoria
 wire controlEndereco, controlEscrita;
 
 or Or0(controlEndereco, subir_pessoa, botao_chamada);
 or Or1(controlEscrita, controlEndereco, andar_visitado);
 
 wire [1:0] acesso_endereco;
 mux_2x1_2bits seletor_endereco_memoria(andar_atual, andar_para_registrar, controlEndereco, acesso_endereco);
 
 // acessando os dados da memoria 
 wire out_terreo, out_primeiro, out_segundo, out_terceiro;
 memoria_registradores celulas_memorias(acesso_endereco, controlEscrita, controlEndereco, leitura_dados_endereco_fornecido, out_terreo, out_primeiro, out_segundo, out_terceiro); 
 
 assign leitura_endereco = leitura_dados_endereco_fornecido;
 
 // operando sobre os dados
 // calculando qual sera o proximo andar 
 seletor_proximo_andar (andar_atual[1], andar_atual[0], movimento_elevador, out_terreo, out_primeiro, out_segundo, out_terceiro, proximo_andar);
 
endmodule


// modulo para marcar o andar como visitado
module marcar_andar_como_visitado(enable, porta_aberta, mesmo_andr, clock, out);
 input enable, clock, porta_aberta, mesmo_andr;
 output out;
 
 wire [2:0] s0;
 
 // contando um tempo antes de fechar a porta novamente
 contador_barra_de_leds contar_5_0(enable, clock, s0);

 wire permissao_escrita;
 mux_2x1 seletor_escrita_dados(s0[2], 1'b1, mesmo_andr, permissao_escrita);
 
 and And0(out, porta_aberta, permissao_escrita);

endmodule
 