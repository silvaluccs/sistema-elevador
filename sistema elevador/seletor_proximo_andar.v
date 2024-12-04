// modulo do seletor do proximo andar, ele que informa a prioridade conforme as entradas atuais

module seletor_proximo_andar(Q1, Q0, S, T, A1, A2, A3, andar);
 input Q1, Q0, S, T, A1, A2, A3;
 output [1:0] andar;
 
 wire not_Q1, not_Q0, not_S, not_T, not_A1, not_A2, not_A3;
 
 not Not0(not_Q1, Q1);
 not Not1(not_Q0, Q0);
 not Not2(not_S, S);
 not Not3(not_T, T);
 not Not4(not_A1, A1);
 not Not5(not_A2, A2);
 not Not6(not_A3, A3);
 
 wire out0, out1;
 
 // configurando out1 agora
 
 wire w0, w1, w2, w3, w4, w5, w6;
 
 nand Nand0(w0, T, Q1);
 and And0(w1, w0, A1);
 
 nand Nand1(w3, Q1, Q0);
 and And1(w4, w3, S, T);
 
 or Or0(w5, w4, w1);
 and And2(w6, w5, A3);
 // w6
 
 
 
 wire p0, p1, p2, p3, p4, p5;
 
 and And3(p0, not_S, not_A3);
 or Or1(p1, p0, T);
 and And4(p2, A1, not_A2, p1);
 
 and And5(p3, T, not_A1, A3);
 or Or2(p4, p3, p2);
 
 and And6(p5, not_Q1, not_Q0, p4);
 // p5
 
 
 wire z0, z1, z2, z3, z4, z5, z6, z7;
 
 and And7(z0, Q0, A1, A2); 
 
 and And8(z1, not_Q0, A3);
 or Or3(z2, z1, A1);
 and And9(z3, Q1, z2); 
 
 or Or4(z4, A3, Q0);
 and And10(z5, z4, not_A1, not_A2); 
 
 or Or5(z6, z5, z3, z0);
 and And11(z7, not_T, z6); // z7
 
 or Or6(out0, z7, p5, w6);
 
 
 // configurando agora o out1
 
 
 wire u0, u1;
 
 or Or7(u0, Q1, A3);
 and And12(u1, not_T, not_A1, u0); // u1
 
 wire k0, k1, k2, k3;
 
 and And13(k0, A2, not_A3);
 and And14(k1, A1, A3);
 or Or8(k2, k0, k1);
 and And15(k3, not_T, k2); 
 
 wire k4, k5, k6, k7, k8;
 or Or9(k4, A3, A2);
 and And16(k5, k4, T);
 and And17(k6, S, not_T, A1);
 or Or10(k7, k6, k5);
 and And18(k8, not_Q0, k7); 
 
 wire k9, k10, k11;
 and And19(k9, S, T, k4); 
 
 or Or11(k10, k9, k8, k3);
 and And20(k11, k10, not_Q1); // k11
 
 wire h0, h1, h2;
 
 or Or12(h0, T, A1);
 and And21(h1, h0, A3);
 and And22(h2, Q1, not_Q0, S, h1); // h2
 
 or Or13(out1, h2, k11, u1);
 
 assign andar = {out1, out0};
endmodule
 