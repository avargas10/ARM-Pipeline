`timescale 1ns/1ns

module instrMemTB();
logic [31:0]inst;
logic clock;
logic [31:0] pc;
logic re;

initial 
	begin
		clock=0;
		pc = 4;
		re = 1;
	end

instr_Mem codeMem(
	.PC(pc),
	.instr(inst),
	.read_enable(re),
	.clk(clock));


always
	begin
		clock<=1; #10;
		clock<=0; #10;
	end 
endmodule
