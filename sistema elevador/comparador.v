// modulo do comparador universal
// se G = 1 entao x > y
// se G = 0 entao x <= y
// se L = 1 entao x < y
// se L = 0 entao x >= y
// se  G = 0 e L = 0 entao x = y
// se G = 1 ou L = 1 entao x != y  

module comparador(G, L, x, y);
 input [1:0] x;
 input [1:0] y;
 output G, L;
 
 wire not_Y1, and_notY1_X1, not_Y0, and_notY0_X0, or_x1_noty1, and_2;
 
 // para G, que indica se o numero eh maior
 
 not notY1(not_Y1, y[1]);
 and and0(and_notY1_X1, not_Y1, x[1]);
 
 not notY0(not_Y0, y[0]);
 and and1(and_notY0_X0, not_Y0, x[0]);
 
 or or0(or_x1_noty1, not_Y1, x[1]);
 and and2(and_2, or_x1_noty1, and_notY0_X0);
 
 or or1(G, and_2, and_notY1_X1);
 
 // para L, que indica se o numero eh menor
 
 wire not_X1, not_X0, and_notX1_Y1, and_notX0_Y0,  or_notX1_Y1, and_5;
 
 not notX1(not_X1, x[1]);
 not notX0(not_X0, x[0]);
 
 and and3(and_notX1_Y1, not_X1, y[1]);
 
 and and4(and_notX0_Y0, not_X0, y[0]);
 or or2(or_notX1_Y1, not_X1, y[1]);
 
 and and5(and_5, or_notX1_Y1, and_notX0_Y0);
 
 or or3(L, and_5, and_notX1_Y1);
 
endmodule