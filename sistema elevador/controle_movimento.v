module controle_movimento(
	input subindo,
	input descendo, 
	output [4:0]colunas,
	output [6:0]linhas
);
	
	//Colunas e linhas para indicar o moviemnto de subida
	wire[4:0]colunas_up;
	wire[6:0]linhas_up;
	
	//Colunas e linhas para indicar o moviemnto de descida
	wire[4:0]colunas_down;
	wire[6:0]linhas_down;
	
	//Modulo "seta_cima"
	seta_cima seta_cima_inst(.colunas(colunas_up), .linhas(linhas_up));
	
	//Modulo "seta_baixo"
	seta_baixo seta_baixo_inst(.colunas(colunas_down), .linhas(linhas_down));
	
	//Lógica para exibir a seta correta 
	assign colunas = subindo ? colunas_up : (descendo ? colunas_down : 5'b00000);
	assign linhas = subindo ? linhas_up : (descendo ? linhas_down : 7'b1111111);
	
endmodule