 module main(clock_in, a, b, c, d, e, f, g, p, d1, d2, d3, d4, controleSubDes);
 input clock_in, controleSubDes;
 output a, b, c, d, e, f, g, p, d1, d2, d3, d4;
 
 wire clock_dividido;
 
 // modulo responsavel por dividir a frequencia inicial da placa
 divisor_frequencia df(clock_dividido, clock_in);
 
 wire [1:0] andar_atual;
 
 // modulo responsavel por modificar o estado do elevador com base em uma chave para subida e descida
 controle_andares controlAndares(andar_atual, controleSubDes, clock_dividido);
 
 // selecionando os displays
 assign d1 = 1'b0;
 assign d2 = 1'b1;
 assign d3 = 1'b1;
 assign d4 = 1'b1;
 assign p = 1'b1;
 
 // configurando o display para exibir o andar atual do elevador
 display_andar displayAndar(andar_atual, a, b, c, d, e, f, g);
endmodule 
