/*
Modulo responsavel pelo flip flop jk
*/

module FF_jk( q, j, k, reset, preset, clock);

  input j, k, clock;
  input reset, preset;
  output q;

  reg q;

  initial begin
    q = 1'b0;
  end

  always @(posedge clock or posedge reset or posedge preset) begin
    if (reset) begin // caso o botao esteja apertado
      q = 1'b0;
    end
	 else if (preset) begin
		q = 1'b1;
	 end
	 
	 else begin
      case ({j, k})
        2'b00: q = q;
        2'b01: q = 1'b0;
        2'b10: q = 1'b1;
        2'b11: q = ~q;
      endcase
    end
  end
endmodule