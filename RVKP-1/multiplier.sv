module multiplier(Rs, Rm, result);
parameter N = 32; 

//for now multiply_long instructions are not implemented
output logic[N-1:0] result;

input logic[N-1:0] Rs;
input logic[N-1:0] Rm;
reg res[31:0];
always*()
begin
    res = Rs*Rm;
    if (res>255) begin
        result = ;
    end
end


endmodule
