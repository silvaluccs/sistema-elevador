/*
Modulo responsavel pelo controle dos andares, subindo e descendo.
*/

module controle_andares(andar, seletor_andar, clock_in);
 input clock_in;
 input [1:0] seletor_andar;
 output [1:0] andar;
 
 wire [1:0] proximoAndar;
 wire [1:0] andarAtual;
 
 wire G, L, controleSubidaDescida, nor_G_L, clock;
 
 comparador comparar_andares(G, L, seletor_andar, proximoAndar);
 
 assign controleSubidaDescida = G;
 
 nor Nor0(nor_G_L, G, L);
 
 mux_2x1 mux_para_clock(clock_in, 1'b0, nor_G_L, clock);
 
 controle_proximo_andar(andarAtual, proximoAndar, controleSubidaDescida);
 
 FF_d FlipFlop_Q1(proximoAndar[1], clock, andarAtual[1]);
 FF_d FlipFlop_Q0(proximoAndar[0], clock, andarAtual[0]);
 
 assign andar = proximoAndar;
 
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
 
 
 
 
 
 