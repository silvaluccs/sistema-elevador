module memoria_ram(andar_atual, andar_pessoa, andar_chamada, subir_pessoa, botao_chamada, movimento_elevador, indicador_porta_aberta, clock_in, leitura_endereco, proximo_andar);
 input [1:0] andar_atual;
 input [1:0] andar_pessoa;
 input [1:0] andar_chamada;
 input subir_pessoa, botao_chamada, movimento_elevador, indicador_porta_aberta, clock_in;
 output  leitura_endereco;
 output [1:0] proximo_andar;
 
 wire [1:0] andar_para_registrar;
 wire andar_visitado, leitura_dados_endereco_fornecido, andar_iguais;
 
 marcar_andar_como_visitado verifica_andar(leitura_dados_endereco_fornecido, indicador_porta_aberta, andar_iguais, clock_in, andar_visitado);
 
 mux_2x1_2bits seletor_andar_gravar(andar_chamada, andar_pessoa, subir_pessoa, andar_para_registrar); 
 
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
 seletor_proximo_andar (andar_atual[1], andar_atual[0], movimento_elevador, out_terreo, out_primeiro, out_segundo, out_terceiro, proximo_andar);
 
endmodule


module marcar_andar_como_visitado(enable, porta_aberta, mesmo_andr, clock, out);
 input enable, clock, porta_aberta, mesmo_andr;
 output out;
 
 wire [2:0] s0;
 
 contador_barra_de_leds contar_5_0(enable, clock, s0);
 
 wire [2:0] s1;
 
 contador_barra_de_leds contar_5_1(s0[2], clock, s1);

 wire permissao_escrita;
 mux_2x1 seletor_escrita_dados(s1[2], 1'b1, mesmo_andr, permissao_escrita);
 
 and And0(out, porta_aberta, permissao_escrita);

endmodule
 