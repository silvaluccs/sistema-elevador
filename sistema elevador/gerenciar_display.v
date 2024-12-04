// modulo para exibir as informaçoes no mostrador de 7 segmentos

module gerenciar_display(andar, A, B, controle_Mux, a, b, c, d, e, f, g);
 input A, B;
 input controle_Mux;
 input [1:0] andar;
 output a, b, c, d, e, f, g;
 
 wire Aa, Ab, Ac, Ad, Ae, Af, Ag;
 
 // display de andar
 display_andar displayAndar(andar, Aa, Ab, Ac, Ad, Ae, Af, Ag);

 wire Pa, Pb, Pc, Pd, Pe, Pf, Pg;

// display de pessoas 
 display_pessoas display_pessoas(A, B, Pa, Pb, Pc, Pd, Pe, Pf, Pg);
 
 mux_2x1 Mux_seg_a(Aa, Pa, controle_Mux, a);
 mux_2x1 Mux_seg_b(Ab,  Pb, controle_Mux, b);
 mux_2x1 Mux_seg_c(Ac, Pc, controle_Mux, c);
 mux_2x1 Mux_seg_d(Ad, Pd, controle_Mux, d);
 mux_2x1 Mux_seg_e(Ae, Pe, controle_Mux, e);
 mux_2x1 Mux_seg_f(Af, Pf, controle_Mux, f);
 mux_2x1 Mux_seg_g(Ag, Pg, controle_Mux, g);


endmodule 