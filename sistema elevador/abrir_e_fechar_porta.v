
// modulo para abrir e fechar a porta
module abrir_e_fechar_porta(control_port, clock_in, L0, L1, L2, L3, L4, L5, L6, L7, L8, L9, port_f, port_a);
 input control_port, clock_in;
 output L0, L1, L2, L3, L4, L5, L6, L7, L8, L9, port_f, port_a;
 
 wire [2:0] cont;
 
 // contador para fazer a animacao
 contador_barra_de_leds contador_animacao_porta(control_port, clock_in, cont);
 
 wire L0_L9, L1_L8, L2_L7, L3_L6;
 
 // ligando os leds L0 e L9
 assign L0_L9 = 1'b1;
 
 assign L0 = L0_L9;
 assign L9 = L0_L9;
 
 // ligando os leds L1 e L8
 or Or0(L1_L8, cont[0], cont[1], cont[2]);
 assign L8 = L1_L8;
 assign L1 = L1_L8;

 // ligando os leds L2 e L7
 or Or1(L2_L7, cont[2], cont[1]);
 assign L2 = L2_L7;
 assign L7 = L2_L7;

 // ligando os leds L3 e L6
 wire and_cont1_cont0;
 and And0(and_cont1_cont0, cont[1], cont[0]);
 or Or2(L3_L6, cont[2], and_cont1_cont0);
 assign L3 = L3_L6;
 assign L6 = L3_L6;
 
 // ligando os leds L4 e L5
 assign L4 = cont[2];
 assign L5 = cont[2];
 
 // indicadores de porta aberta e fechada
 not not0(port_a, L1);
 assign port_f = L4;
 
endmodule

// modulo para fazer a contagem da animacao do led
module contador_barra_de_leds(controle_porta, clock, out);

 input controle_porta, clock;
 output [2:0] out;
 
 wire [2:0] atual_estado;
 wire [2:0] estado_proximo;
 
 // configurando o proximo estado do FF T
 controle_ff_barra_leds controle_fft(controle_porta, estado_proximo, atual_estado);
 
 tff contador_numero_0(.clk(clock), .t(atual_estado[0]), .q(estado_proximo[0]));
 tff contador_numero_1(.clk(clock), .t(atual_estado[1]), .q(estado_proximo[1]));
 tff contador_numero_2(.clk(clock), .t(atual_estado[2]), .q(estado_proximo[2]));
 
 assign Saida = estado_proximo;
 
endmodule 

module controle_ff_barra_leds(controle_por, entrada, saida);
 
 input controle_por;
 input [2:0] entrada;
 output [2:0] saida;
 
 // para saida 0
 wire xor_controle_e2;
 
 xor Xor0(xor_controle_e2, controle_por, entrada[2]);
 or Or0(saida[0], entrada[0], entrada[1], xor_controle_e2);
 
 // para saida 1
 
 wire not_controle, not_e0, and_controle_e0, and_e1_note0, or_e2_and_e1_note0, and_Or1_not_controle;
 
 not Not0(not_controle, controle_por);
 not Not1(not_e0, entrada[0]);
 
 and And0(and_controle_e0, controle_por, entrada[0]);
 
 and And1(and_e1_note0, entrada[1], not_e0);
 or Or1(or_e2_and_e1_note0, entrada[2], and_e1_note0);
 and And2(and_Or1_not_controle, or_e2_and_e1_note0, not_controle);
 
 or Or2(saida[1], and_Or1_not_controle, and_controle_e0);
 
 
 // para saida 2
 
 wire not_controle_e2, controle_e1_e0;
 
 and And3(not_controle_e2, not_controle, entrada[2]);
 
 and And4(controle_e1_e0, controle_por, entrada[1], entrada[0]);
 
 or Or3(saida[2], not_controle_e2, controle_e1_e0);
 
endmodule 