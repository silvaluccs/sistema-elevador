// modulo responsavel pela contagem das pessoas no elevador

module contagem_pessoas(
    input btn_add,       
    input btn_sub,       
    input clock,         
    input reset,         
    output [1:0] capacidade_atual  
);

    wire capacidade_add, capacidade_sub;
    wire [1:0] capacidade_temp;

    FF_d FF0(capacidade_temp[0], clock, capacidade_add);  
    FF_d FF1(capacidade_temp[1], clock, capacidade_sub);  

    and and_add(capacidade_add, btn_add, ~(capacidade_temp[0] & capacidade_temp[1])); 

   
    
    and and_sub(capacidade_sub, btn_sub, |capacidade_temp); 

    
    assign capacidade_atual = capacidade_temp;

endmodule