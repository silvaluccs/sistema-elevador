/*
Modulo responsavel pelo controle dos andares, subindo e descendo.
*/

module controle_andares(andar, seletor_andar, clock_in, porta_fechada, pessoa_para_descer, S, P, abrir_fechar_porta);
 input clock_in, porta_fechada, pessoa_para_descer;
 input [1:0] seletor_andar;
 output [1:0] andar;
 output abrir_fechar_porta;
 output S, P;
 
 wire [1:0] proximoAndar;
 wire [1:0] andarAtual;
 
 wire G, L, controleSubidaDescida, or_G_L, clock, permitir_movimento;
 
 comparador comparar_andares(G, L, seletor_andar, proximoAndar);
 
 assign controleSubidaDescida = G;
 
 wire not_pessoa_para_descer;
 not Not0(not_pessoa_para_descer, pessoa_para_descer);
 
 nor Or0(or_G_L, G, L);
 and And0(permitir_movimento, not_pessoa_para_descer, or_G_L, porta_fechada);
 
 mux_2x1 seletor_porta_abrir_fechar(or_G_L, 1'b0, pessoa_para_descer, abrir_fechar_porta);
 
 mux_2x1 mux_para_clock(clock_in, 1'b0, permitir_movimento, clock);
 
 controle_proximo_andar(andarAtual, proximoAndar, controleSubidaDescida);
 
 FF_d FlipFlop_Q1(proximoAndar[1], clock, andarAtual[1]);
 FF_d FlipFlop_Q0(proximoAndar[0], clock, andarAtual[0]);
 
 assign andar = proximoAndar;
 assign S = controleSubidaDescida;
 assign P = permitir_movimento;
 
endmodule

/*
modulo para configurar o proximo estado do elevador
*/

module controle_proximo_andar(proximoAndar, andarAtual, controleSubidaDescida);
 input controleSubidaDescida;
 input [1:0] andarAtual;
 output [1:0] proximoAndar;
 
 // configurando o proximo estado do lsb
 wire notLSB, and_notLSB_ControleSubDes, xnor_LSB_ControleSubDes, and_MSB_Xnor0;
 
 not not_lsb(notLSB, andarAtual[0]);
 and And0(and_notLSB_ControleSubDes, notLSB, controleSubidaDescida);
 
 xnor Xnor0(xnor_LSB_ControleSubDes, andarAtual[0], controleSubidaDescida);
 and And1(and_MSB_Xnor0, andarAtual[1], xnor_LSB_ControleSubDes);
 
 or Or0(proximoAndar[0], and_notLSB_ControleSubDes, and_MSB_Xnor0);
 
 // configurando o proximo estado do msb
 
 wire and_LSB_controleSubDes, xor_lsb_controleSubDesc, and_MSB_Xor0;
 
 and And2(and_LSB_controleSubDes, andarAtual[0], controleSubidaDescida);
 
 xor Xor0(xor_lsb_controleSubDesc, andarAtual[0], controleSubidaDescida);
 and And3(and_MSB_Xor0, andarAtual[1], xor_lsb_controleSubDesc);
 
 or Or1(proximoAndar[1], and_MSB_Xor0, and_LSB_controleSubDes);
 
endmodule
 
 
 
 
 
 