module multiplier(Rs, Rm, result);
parameter N = 32; 

//for now multiply_long instructions are not implemented
output logic[N-1:0] result;

input logic[N-1:0] Rs;
input logic[N-1:0] Rm;
logic[N-1:0] res;
assign res = Rs*Rm;     
assign result = ( res > 8'd255) ? 8'd255 : res;

endmodule
