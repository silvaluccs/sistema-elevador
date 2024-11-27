// modulo para configurar os segmentos do mostrador conforme o numero de pessoas no elevador

module display_pessoas(A, B, a, b, c, d, e, f, g);
 input A, B;
 output a, b, c, d, e, f, g;
 
 wire not_A, not_B;
 
 not Not0(not_A, A);
 not Not1(not_B, B);
 
 wire and_notA_B;
 
 and And0(and_notA_B, not_A, B);
 assign a = and_notA_B;
 assign d = and_notA_B;
 
 assign b = 1'b0;
 
 and And1(c, A, not_B);
 
 assign e = B;
 
 or Or0(f, A, B);
 
 assign g = not_A;
 
endmodule