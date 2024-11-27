module main(clock_in, btn_add, btn_sub, led_rgb, chave1, chave0, a, b, c, d, e, f, g, p, d1, d2, d3, d4);
    input chave1, chave0;
	 input clock_in, btn_add, btn_sub;
    output [1:0] led_rgb;
    output a, b, c, d, e, f, g, p, d1, d2, d3, d4;
 
 wire clock_dividido, clock_debouce, clock_display;
 
 // modulo responsavel por dividir a frequencia inicial da placa
 divisor_frequencia df(clock_dividido, clock_debouce, clock_display, clock_in);
 
 wire [1:0] andar_atual;
 wire [1:0] seletor_andar;
 
 assign seletor_andar = {chave1, chave0};
 
 // modulo responsavel por modificar o estado do elevador com base em uma chave para selecionar o andar
 controle_andares controlAndares(andar_atual, seletor_andar, clock_dividido);
 
 //modulo responsavel pela contagem de pessoas
 wire BotaoSomar, BotaoDecrementar, alerta_capacidade;
 wire [1:0] quantidadePessoas;
 
 // limpando o ruido do botao
 debouce(btn_add, clock_debouce, BotaoSomar);
 debouce(btn_sub, clock_debouce, BotaoDecrementar);

// maquina de estado para a contagem de pessoas 
 contagem_pessoas_no_elevador contador_pessoas_elevador(clock_debouce, BotaoSomar, BotaoDecrementar, alerta_capacidade, quantidadePessoas);
 
 // acionando os leds caso a capacidade tenha se esgotado
 assign led_rgb[1] = alerta_capacidade;
 not notAlertaCapacidade(led_rgb[0], alerta_capacidade);
 
 // selecionando os displays
 assign d1 = clock_display;
 not notClockDisplay(d4, clock_display);
 assign d3 = 1'b1;
 assign d2 = 1'b1;
 assign p = 1'b1;

 
 // configurando o display para exibir o andar atual do elevador e a quantidade de pessoas
 gerenciar_display gerenciandoDisplay(andar_atual, quantidadePessoas[1], quantidadePessoas[0], clock_display, a, b, c, d, e, f, g);

endmodule 