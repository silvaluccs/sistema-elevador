/*
modulo para o fliflop d
*/

module FF_d(Q, clk, D);
  input D; // entrada D 
  input clk; // clock entrada 
  output reg Q; // saida Q 

  initial begin
    Q = 1'b0;
  end

  always @(posedge clk) begin
    Q <= D; 
  end 
endmodule 