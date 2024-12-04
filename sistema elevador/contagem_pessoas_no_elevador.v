// modulo responsavel pela maquina de estados que indica a quantidade de
// pessoas no elevador

module contagem_pessoas_no_elevador(clock, botao_subir, botao_descer, porta_aberta, alerta, quantidade_pessoas);
 input clock, botao_descer, botao_subir, porta_aberta;
 output alerta;
 output [1:0] quantidade_pessoas;

 wire [1:0] estado_atual;
 wire [1:0] proximo_estado;
 
 controle_quantidade_pessoas_no_elevador control_quant_pes(proximo_estado, estado_atual, botao_subir, botao_descer, alerta);
 
 wire permitir_subir_pessoas;
 
 mux_2x1 permicao_subir(1'b0, clock, porta_aberta, permitir_subir_pessoas);
 
 FF_d Y0(proximo_estado[0], permitir_subir_pessoas, estado_atual[0]);
 FF_d Y1(proximo_estado[1], permitir_subir_pessoas, estado_atual[1]);
 
 assign quantidade_pessoas = proximo_estado;
 
 
endmodule

// modulo de controle para o proximo estado

module controle_quantidade_pessoas_no_elevador(entrada, saida, botao_sub, botao_des, Sinalalerta);
 input [1:0] entrada;
 input botao_sub, botao_des;
 output [1:0] saida;
 output Sinalalerta;
 
 wire not_botao_sub, not_botao_des, not_y1;
 
 not Not0(not_botao_sub, botao_sub);
 not Not1(not_botao_des, botao_des);
 not Not2(not_y1, entrada[0]);
 
 wire AD_xnor, Y_AD_xnor, Y1_Y2_or, AD_Y1_Y2_or, DAY1Y2;

 // configurando D0
 xnor Xnor0(AD_xnor, botao_sub, botao_des);
 and And0(Y_AD_xnor, entrada[0], AD_xnor);

 or Or0(Y1_Y2_or, not_y1, entrada[1]);
 and And1(AD_Y1_Y2_or, Y1_Y2_or, botao_sub, not_botao_des);
 
 and And2(DAY1Y, not_botao_sub, botao_des, entrada[1], not_y1);
 
 or Or1(saida[0], DAY1Y, AD_Y1_Y2_or, Y_AD_xnor);
 
 // configurando D1)
 
 
 wire notD_A_y1, y1_A_notd_or, y2_and_y1_A_notd_or;
 
 and And3(notD_A_y1, botao_sub, not_botao_des, entrada[0]);
 
 or Or2(y1_A_notd_or, entrada[0], botao_sub, not_botao_des);
 and And4(y2_and_y1_A_notd_or, entrada[1], y1_A_notd_or);
 
 or Or3(saida[1], y2_and_y1_A_notd_or, notD_A_y1);
 
 // configurando o led de alerta
 and And5(Sinalalerta, entrada[0], entrada[1], botao_sub);

endmodule
 

 