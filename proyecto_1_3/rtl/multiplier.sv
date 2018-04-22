module multiplier(Rs, Rm, result);
parameter N = 32; 

//for now multiply_long instructions are not implemented
output logic[N-1:0] result;
//output reg[3:0] nzcv;
//input wire[N-1:0] Rn;
input logic[N-1:0] Rs;
input logic[N-1:0] Rm;
//input wire A;	//this bit says if this is accumulate instruction or not.

assign result = Rm*Rs;
//nzcv = {result[32], (result == 0),1'bx,1'bx}; //c,v don't unpredictable

endmodule
