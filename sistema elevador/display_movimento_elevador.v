module display_movimento_elevador(S, D, P, a, b, c, d, e, f, g);
 input S, D, P;
 output a, b, c, d, e, f, g;
 
 wire not_S, not_P, and_notS_notP;
 
 not Not0(not_S, S);
 not Not1(not_P, P);
 
 and and0(and_notS_notP, not_P, not_S);
 
 assign a = and_notS_notP;
 assign f = and_notS_notP;
 assign b = S;
 assign e = S;
 assign c = P;
 assign d = P;
 assign g = 1'b0;

endmodule