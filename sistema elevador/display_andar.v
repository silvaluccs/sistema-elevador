module display_andar(andar, a, b, c, d, e, f, g);
 input [1:0] andar;
 output a, b, c, d, e, f, g;
 
 wire notMSB, notLSB;
 
 not not_msb(notMSB, andar[1]);
 not not_lsb(notLSB, andar[0]);
 
 // para o seg a
 assign a = notMSB;
 
 // para o seg b
 and And0(b, notLSB, notMSB);
 
 // para o seg c
 
 assign c = notLSB;
 
 // para o d e g
 
 wire and_notMSM_LSB;
 
 and and1(and_notMSM_LSB, notMSB, andar[0]);
 assign d = and_notMSM_LSB;
 assign g = and_notMSM_LSB;
 
 assign e = andar[0];
 
 or Or0(f, andar[0], andar[1]);
 
endmodule 