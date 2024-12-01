module mux_2x1_2bits(a, b, sel, out);
 input [1:0] a;
 input [1:0] b;
 input sel;
 output [1:0] out;
 
 wire s0, s1;
 
 mux_2x1 mux_para_lsb(a[0], b[0], sel, s0);
 mux_2x1 mux_para_msb(a[1], b[1], sel, s1);
 
 assign out = {s1, s0};
 
endmodule
 