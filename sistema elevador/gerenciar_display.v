// modulo para exibir as informaçoes no mostrador de 7 segmentos

module gerenciar_display(andar, A, B, S, D, P, controle_Mux, a, b, c, d, e, f, g);
 input A, B, S, D, P;
 input [1:0] controle_Mux;
 input [1:0] andar;
 output a, b, c, d, e, f, g;
 
 wire Aa, Ab, Ac, Ad, Ae, Af, Ag;
 
 display_andar displayAndar(andar, Aa, Ab, Ac, Ad, Ae, Af, Ag);
 
 wire MOVA, MOVB, MOVC, MOVD, MOVE, MOVF, MOVG;
 display_movimento_elevador display_movimento(S, D, P, MOVA, MOVB, MOVC, MOVD, MOVE, MOVF, MOVG);
 
 wire Pa, Pb, Pc, Pd, Pe, Pf, Pg;
 
 display_pessoas display_pessoas(A, B, Pa, Pb, Pc, Pd, Pe, Pf, Pg);
 
 mux_4x1 Mux_seg_a(Aa, MOVA, 1'b1, Pa, controle_Mux, a);
 mux_4x1 Mux_seg_b(Ab, MOVB, 1'b1, Pb, controle_Mux, b);
 mux_4x1 Mux_seg_c(Ac, MOVC, 1'b1, Pc, controle_Mux, c);
 mux_4x1 Mux_seg_d(Ad, MOVD, 1'b1, Pd, controle_Mux, d);
 mux_4x1 Mux_seg_e(Ae, MOVE, 1'b1, Pe, controle_Mux, e);
 mux_4x1 Mux_seg_f(Af, MOVF, 1'b1, Pf, controle_Mux, f);
 mux_4x1 Mux_seg_g(Ag, MOVG, 1'b1, Pg, controle_Mux, g);


endmodule