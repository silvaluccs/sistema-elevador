// Modulo que configura a seta para cima 
module seta_cima(
	 output [4:0] colunas,
    output [6:0] linhas
);

    // Definindo o padrão da seta para cima
    assign colunas = 5'b00100; // Ativandando a coluna 3
	 
	 //Configurando as linhas para formar uma seta para cima
    assign linhas[0] = 7'b11011;  // Primeira linha 
    assign linhas[1] = 7'b10001;  // Segunda linha 
    assign linhas[2] = 7'b00000;  // Terceira linha 
    assign linhas[3] = 7'b11011;  // Quarta linha 
    assign linhas[4] = 7'b11011;  // Quinta linha 
	 assign linhas[5] = 7'b11011;  // Sexta linha 
	 assign linhas[6] = 7'b11011;  // Sètima linha 

endmodule