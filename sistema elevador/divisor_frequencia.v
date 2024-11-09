/*
*	Modulo responsavel por dividir o clock com flipflops jk
*  O clock tem aproximadamente 0,75 Hz
*
*/

module divisor_frequencia(clock_out, clock_entrada);
	input clock_entrada;
	output clock_out;
	
	
	wire [25:0] clock_temp;
	wire botao;
	
	assign botao = 1'b0;
	
	// divide a frequencia do clock para aproximadamente 0,75 Hz
	
	FF_jk FF_jk1(.q(clock_temp[0]), .j(1'b1), .k(1'b1), .reset(botao), .clock(clock_entrada));
	FF_jk FF_jk2(.q(clock_temp[1]), .j(1'b1), .k(1'b1), .reset(botao), .clock(clock_temp[0]));
	FF_jk FF_jk3(.q(clock_temp[2]), .j(1'b1), .k(1'b1), .reset(botao), .clock(clock_temp[1]));
	FF_jk FF_jk4(.q(clock_temp[3]), .j(1'b1), .k(1'b1), .reset(botao), .clock(clock_temp[2]));
	FF_jk FF_jk5(.q(clock_temp[4]), .j(1'b1), .k(1'b1), .reset(botao), .clock(clock_temp[3]));
	FF_jk FF_jk6(.q(clock_temp[5]), .j(1'b1), .k(1'b1), .reset(botao), .clock(clock_temp[4]));
	FF_jk FF_jk7(.q(clock_temp[6]), .j(1'b1), .k(1'b1), .reset(botao), .clock(clock_temp[5]));
	FF_jk FF_jk8(.q(clock_temp[7]), .j(1'b1), .k(1'b1), .reset(botao), .clock(clock_temp[6]));
	FF_jk FF_jk9(.q(clock_temp[8]), .j(1'b1), .k(1'b1), .reset(botao), .clock(clock_temp[7]));
	FF_jk FF_jk10(.q(clock_temp[9]),  .j(1'b1), .k(1'b1), .reset(botao), .clock(clock_temp[8]));
	FF_jk FF_jk11(.q(clock_temp[10]), .j(1'b1), .k(1'b1), .reset(botao), .clock(clock_temp[9]));
	FF_jk FF_jk12(.q(clock_temp[11]), .j(1'b1), .k(1'b1), .reset(botao), .clock(clock_temp[10]));
	FF_jk FF_jk13(.q(clock_temp[12]), .j(1'b1), .k(1'b1), .reset(botao), .clock(clock_temp[11]));
	FF_jk FF_jk14(.q(clock_temp[13]), .j(1'b1), .k(1'b1), .reset(botao), .clock(clock_temp[12]));
	FF_jk FF_jk15(.q(clock_temp[14]), .j(1'b1), .k(1'b1), .reset(botao), .clock(clock_temp[13]));
	FF_jk FF_jk16(.q(clock_temp[15]), .j(1'b1), .k(1'b1), .reset(botao), .clock(clock_temp[14]));
	FF_jk FF_jk17(.q(clock_temp[16]), .j(1'b1), .k(1'b1), .reset(botao), .clock(clock_temp[15]));
	FF_jk FF_jk18(.q(clock_temp[17]), .j(1'b1), .k(1'b1), .reset(botao), .clock(clock_temp[16]));
	FF_jk FF_jk19(.q(clock_temp[18]), .j(1'b1), .k(1'b1), .reset(botao), .clock(clock_temp[17]));
	FF_jk FF_jk20(.q(clock_temp[19]), .j(1'b1), .k(1'b1), .reset(botao), .clock(clock_temp[18]));
	FF_jk FF_jk21(.q(clock_temp[20]), .j(1'b1), .k(1'b1), .reset(botao), .clock(clock_temp[19]));
	FF_jk FF_jk22(.q(clock_temp[21]), .j(1'b1), .k(1'b1), .reset(botao), .clock(clock_temp[20]));
	FF_jk FF_jk23(.q(clock_temp[22]), .j(1'b1), .k(1'b1), .reset(botao), .clock(clock_temp[21]));
	FF_jk FF_jk24(.q(clock_temp[23]), .j(1'b1), .k(1'b1), .reset(botao), .clock(clock_temp[22]));
	FF_jk FF_jk25(.q(clock_temp[24]), .j(1'b1), .k(1'b1), .reset(botao), .clock(clock_temp[23]));
	FF_jk FF_jk26(.q(clock_temp[25]), .j(1'b1), .k(1'b1), .reset(botao), .clock(clock_temp[24]));
	
	wire bit0, bit1, bit2;
	
	// instancia dos bits contadores do flipflop
	FF_jk FF_contador0(.q(bit0), .j(1'b1), .k(1'b1), .reset(botao), .clock(clock_temp[25]));
	FF_jk FF_contador1(.q(bit1), .j(1'b1), .k(1'b1), .reset(botao), .clock(bit0));
	FF_jk FF_contador2(.q(bit2), .j(1'b1), .k(1'b1), .reset(botao), .clock(bit1));
	
	assign clock_out = bit2;
	
endmodule	