module main(clock_in, btn_add, btn_sub, led_rgb, chave1, chave0, a, b, c, d, e, f, g, p, d1, d2, d3, d4);
    input chave1, chave0;
	 input clock_in, btn_add, btn_sub;
    output [2:0] led_rgb;
    output a, b, c, d, e, f, g, p, d1, d2, d3, d4;
 
 wire clock_dividido;
 
 // modulo responsavel por dividir a frequencia inicial da placa
 divisor_frequencia df(clock_dividido, clock_in);
 
 wire [1:0] andar_atual;
 wire [1:0] seletor_andar;
 
 assign seletor_andar = {chave1, chave0};
 
 // modulo responsavel por modificar o estado do elevador com base em uma chave para selecionar o andar
 controle_andares controlAndares(andar_atual, seletor_andar, clock_dividido);
 
 //modulo responsavel pela contagem de pessoas
 contagem_pessoas contador(
        .btn_add(btn_add), 
        .btn_sub(btn_sub), 
        .clock(clock_dividido), 
        .reset(1'b0), 
        .capacidade_atual(capacidade_atual)
    );
 
 // selecionando os displays
 assign d1 = 1'b0;
 assign d2 = 1'b1;
 assign d3 = 1'b1;
 assign d4 = 1'b1;
 assign p = 1'b1;
 
 //modulo responsavel pelo controle de capacidade e exibição na led rgb
 controle_capacidade controleCapacidade(capacidade_atual, led_rgb);
 
 // configurando o display para exibir o andar atual do elevador
 display_andar displayAndar(andar_atual, a, b, c, d, e, f, g);
endmodule 