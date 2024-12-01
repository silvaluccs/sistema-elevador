module main(clock_in, btn_add, btn_sub, btn_confirma, led_rgb, chave1, chave0, chave3, chave2, a, b, c, d, e, f, g, p, d1, d2, d3, d4, l0, l1, l2, l3, l4, l5, l6, l7, l8, l9);
    input chave1, chave0, chave3, chave2;
	 input clock_in, btn_add, btn_sub, btn_confirma;
    output [1:0] led_rgb;
	 output l0, l1, l2, l3, l4, l5, l6, l7, l8, l9;
    output a, b, c, d, e, f, g, p, d1, d2, d3, d4;
 
 wire clock_dividido, clock_debouce, clock_display;
 
 // modulo responsavel por dividir a frequencia inicial da placa
 divisor_frequencia df(clock_dividido, clock_debouce, clock_display, clock_in);
 
 // modulo responsavel pelo controle da porta abrindo e fechando
 wire controle_porta, porta_aberta, porta_fechada;
 
 abrir_e_fechar_porta estado_porta(controle_porta, clock_dividido, l0, l1, l2, l3, l4, l5, l6, l7, l8, l9, porta_fechada, porta_aberta);
 
 wire [1:0] andar_atual;
 wire [1:0] seletor_andar_chamada;
 wire [1:0] seletor_andar_pessoa;
 wire Subindo, Descendo, Parado, pessoa_para_descer;
 wire [1:0] andar_proximo;
 
 assign seletor_andar_chamada = {chave1, chave0};
 assign seletor_andar_pessoa = {chave3, chave2};
 
  //modulo responsavel pela contagem de pessoas
 wire BotaoSomar, BotaoDecrementar, alerta_capacidade, BotaoConfirmaChamada, parar_elevador;
 wire [1:0] quantidadePessoas;
 
 // limpando o ruido do botao
 debouce botao_adicionar_pessoa(btn_add, clock_debouce, BotaoSomar);
 debouce botao_subtrair_pessoa(btn_sub, clock_debouce, BotaoDecrementar);
 debouce botao_confirmar_chamada(btn_confirma, clock_debouce, BotaoConfirmaChamada);

// maquina de estado para a contagem de pessoas 
 contagem_pessoas_no_elevador contador_pessoas_elevador(clock_debouce, BotaoSomar, BotaoDecrementar, porta_aberta,alerta_capacidade, quantidadePessoas);
 
 
 memoria_ram gerenciar_memoria_elevador(andar_atual, seletor_andar_pessoa, seletor_andar_chamada, BotaoSomar, BotaoConfirmaChamada, Subindo, porta_aberta, clock_dividido, parar_elevador, andar_proximo);
 
 // modulo responsavel por modificar o estado do elevador com base em uma chave para selecionar o andar
 controle_andares controlAndares(andar_atual, andar_proximo, clock_dividido, porta_fechada, parar_elevador,Subindo, Parado, controle_porta);
 
 not NotSubindo(Descendo, Subindo);
 

 // acionando os leds caso a capacidade tenha se esgotado
 assign led_rgb[1] = alerta_capacidade;
 not notAlertaCapacidade(led_rgb[0], alerta_capacidade);
 
 // selecionando os displays
 wire Out4, Out3, Out2, Out1;
 
 demux_1x4 demux_selecionar_display(clock_display, 1'b1, Out4, Out3, Out2, Out1);

 not AtivarD1(d1, Out1);
 not AtivarD2(d2, Out2);
 not AtivarD4(d4, Out4);

 assign d3 = 1'b1;
 assign p = 1'b1;

 
 // configurando o display para exibir o andar atual do elevador e a quantidade de pessoas
 gerenciar_display gerenciandoDisplay(andar_atual, quantidadePessoas[1], quantidadePessoas[0],Subindo, Descendo, Parado, clock_display, a, b, c, d, e, f, g);

endmodule 