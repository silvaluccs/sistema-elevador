// modulo responsavel pelo controle da capacidade do elevador

module controle_capacidade(capacidade_atual, led_rgb);
    input [1:0] capacidade_atual;  
    output [2:0] led_rgb;           

    wire capacidade_excedida;  

    
    and and1(capacidade_excedida, capacidade_atual[1], capacidade_atual[0]);

    assign led_rgb[2] = capacidade_excedida;  
    assign led_rgb[1] = ~capacidade_excedida; 
    assign led_rgb[0] = 1'b0;                 
endmodule