module instr_Mem(PC,instr,read_enable,clk);
parameter addr_size = 8;
reg [31:0] ram [255:0];
input read_enable;
input [31:0]PC;
input clk;
output reg [31:0] instr;

initial begin
	$readmemh("code_Mem.txt",ram);
end


always @ (negedge clk)	
begin
	if(read_enable==1) begin
		instr= ram[PC[addr_size+1:2]];
	end
end

endmodule
