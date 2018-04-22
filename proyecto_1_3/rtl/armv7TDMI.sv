`timescale 1ns/1ns

module armv7TDMI();
logic clock;

pipeline micro(
    .clk(clock));

initial 
	begin
		clock=0;  
    end
always
	begin
		clock<=1; #50;
		clock<=0; #50;
	end 
endmodule
