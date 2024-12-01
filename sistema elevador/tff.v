module tff(clk,t,q);
input clk,t;
output reg q;

always @ (posedge clk)begin
    if(t == 0)
        q <= q;
    else 
        q = ~q;
end
                
endmodule
