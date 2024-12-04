// modulo priincipal do sistema

module main(clock_in, btn_add, btn_sub, btn_confirma,  disparo_sonoro, , led_rgb, chave1, chave0, chave3, chave2, a, b, c, d, e, f, g, p, d1, d2, d3, d4, l0, l1, l2, l3, l4, l5, l6, l7, l8, l9);
    input chave1, chave0, chave3, chave2;
	 input clock_in, btn_add, btn_sub, btn_confirma;
    output [2:0] led_rgb;
	 output l0, l1, l2, l3, l4, l5, l6, l7, l8, l9;
    output a, b, c, d, e, f, g, p, d1, d2, d3, d4;
	 output disparo_sonoro;
 
 
 // modulo responsavel por dividir a frequencia inicial da placa
 wire clock_dividido, clock_debouce, clock_display;
 
 divisor_frequencia df(clock_dividido, clock_debouce, clock_display, clock_in);
 
 // modulo responsavel pelo controle da porta abrindo e fechando
 wire controle_porta, porta_aberta, porta_fechada;
 
 abrir_e_fechar_porta estado_porta(controle_porta, clock_dividido, l0, l1, l2, l3, l4, l5, l6, l7, l8, l9, porta_fechada, porta_aberta);
 
 // modulo responsavel pela contagem de pessoas
 
 wire [1:0] andar_atual;
 wire [1:0] seletor_andar_chamada;
 wire [1:0] seletor_andar_pessoa;
 wire Subindo, Descendo, Parado, pessoa_para_descer;
 wire [1:0] andar_proximo;
 
 assign seletor_andar_chamada = {chave1, chave0};
 assign seletor_andar_pessoa = {chave3, chave2};
 
 wire BotaoSomar, BotaoDecrementar, alerta_capacidade, parar_elevador, BotaoConfirma;
 wire [1:0] quantidadePessoas;
 
 controle_andares controlAndares(andar_atual, andar_proximo, clock_dividido, porta_fechada, parar_elevador,Subindo, Parado, controle_porta);
 
 // limpando o ruido do botaoBotaoConfirmaChamada
 debouce botao_adicionar_pessoa(~btn_add, clock_debouce, BotaoSomar);
 debouce botao_subtrair_pessoa(~btn_sub, clock_debouce, BotaoDecrementar);
 debouce botao_confirma_chamda(~btn_confirma, clock_debouce, BotaoConfirma);

 // maquina de estado para a contagem de pessoas 
 contagem_pessoas_no_elevador contador_pessoas_elevador(clock_debouce, BotaoSomar, BotaoDecrementar, porta_aberta,alerta_capacidade, quantidadePessoas);
 
 // chamando o modulo responsavel pela memoria ram
 
 memoria_ram_2 gerenciar_memoria_elevador(andar_atual, seletor_andar_pessoa, seletor_andar_chamada, BotaoSomar, BotaoConfirma, Subindo, porta_aberta, clock_dividido, parar_elevador, andar_proximo, porta_fechada, quantidadePessoas);
 
 // acionando os leds caso a capacidade tenha se esgotado
 assign disparo_sonoro = alerta_capacidade;
 
 // selecionando os displays
 assign d1 = clock_display;
 assign d4 = ~d1;

 assign d2 = 1'b1;
 assign d3 = 1'b1;
 assign p = 1'b1;

 
  // configurando o display para exibir o andar atual do elevador e a quantidade de pessoas
  gerenciar_display gerenciandoDisplay(andar_atual, quantidadePessoas[1], quantidadePessoas[0], clock_display, a, b, c, d, e, f, g);

  // acionando os indicadores do movimento do elevador
  wire notParado, notSubindo, notDescendo; 

  not Not_Subindo(notSubindo, Subindo);
  not Not_Parado(notParado, Parado);
  not Not_Descendo(notDescendo, Descendo); 
  
  not NotSubindo(Descendo, Subindo);
  and And_LedAzul(led_rgb[2], Descendo, notParado);
  
  and And_LedVerde(led_rgb[1], Subindo, notParado);

  assign led_rgb[0] = Parado;
  
 
endmodule 