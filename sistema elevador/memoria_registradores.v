module memoria_registradores(endereco, escrita, dado, saida_endereco, terreo, primeiro_andar, segundo_andar, terceiro_andar);
 input [1:0] endereco;
 input escrita, dado;
 output saida_endereco, terreo, primeiro_andar, segundo_andar, terceiro_andar;
 
 wire regist1, regist2, regist3, regist4;
 
 // demux para escolher em qual celula os dados vao ser registrado
 demux_1x4 Seletor_escrita_dados(endereco, 1'b1, regist4, regist3, regist2, regist1);
 
 wire registrar_na_celula_terreo, registrar_na_celula_primeiro_andar;
 wire registrar_na_celula_segundo_andar, registrar_na_celula_terceiro_andar;
 
 // selecionando a celula
 and And0(registrar_na_celula_terreo, regist1, escrita);
 and And1(registrar_na_celula_primeiro_andar, regist2, escrita);
 and And2(registrar_na_celula_segundo_andar, regist3, escrita);
 and And3(registrar_na_celula_terceiro_andar, regist4, escrita);
 
 wire s_terreo, s_1, s_2, s_3; 

 // gravando os dados na celelua 
 registrador celula_terreo(dado, registrar_na_celula_terreo, s_terreo);
 registrador celula_primeiro_andar(dado, registrar_na_celula_primeiro_andar, s_1);
 registrador celula_segundo_andar(dado, registrar_na_celula_segundo_andar, s_2);
 registrador celula_terceiro_andar(dado, registrar_na_celula_terceiro_andar, s_3);
 
 assign terreo = s_terreo;
 assign primeiro_andar = s_1;
 assign segundo_andar = s_2;
 assign terceiro_andar = s_3;
 
 wire dado_endereco, leitura;
 mux_4x1 seletor_exibir_dados(s_terreo, s_1, s_2, s_3, endereco, dado_endereco);
 
 not Not0(leitura, escrita);
 
 mux_2x1 seletor_leitura_dados(1'b0, dado_endereco, leitura, saida_endereco);
 
 endmodule

 
module registrador(dados_in, permitir_escrever, saida);
 input dados_in, permitir_escrever;
 output saida;
 
FF_d registar_Dados(saida, permitir_escrever, saida);
endmodule 