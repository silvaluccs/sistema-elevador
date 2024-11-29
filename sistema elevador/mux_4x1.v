module mux_4x1(a, b, c, d, sel, out);
  input a, b, c, d;
  input [1:0] sel;

  output out;

  wire w0, w1, w2, w3;

  and and0(w0, a, ~sel[1], ~sel[0]);
  and and1(w1, b, ~sel[1], sel[0]);
  and and2(w2, c, sel[1], ~sel[0]);
  and and3(w3, d, sel[1], sel[0]);

  or or0(out, w0, w1, w2, w3);
endmodule