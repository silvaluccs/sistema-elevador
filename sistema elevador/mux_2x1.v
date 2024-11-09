// modulo para o mux 2X1

module mux_2x1(a, b, sel, out);
	input a, b, sel;

	output out;

	wire w0, w1;

	and and0(w0, a, ~sel);
	and and1(w1, b, sel);

	or or0(out, w0, w1);
	
endmodule