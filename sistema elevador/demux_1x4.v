// modulo responsavel pelo demux 1x4

module demux_1x4(Sel, E, Out4, Out3, Out2, Out1);
	input [1:0] Sel;
	input E;
	output Out1, Out2, Out3, Out4;

	wire W0, W1, W2, W3;

	demux_1x2 d0(.Sel(Sel[1]), .E(E), .Out2(W0), .Out1(W1));

	demux_1x2 d2(.Sel(Sel[0]), .E(W0), .Out2(Out4), .Out1(Out3));
	demux_1x2 d1(.Sel(Sel[0]), .E(W1), .Out2(Out2), .Out1(Out1));

endmodule

module demux_1x2(Sel, E, Out2, Out1);
  input Sel, E;
  output Out2, Out1;

  and and1(Out2, Sel, E);
  and and2(Out1, ~Sel, E);
endmodule