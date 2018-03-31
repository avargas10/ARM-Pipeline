`timescale 1ns/1ns

module multiplierTB();
logic [31:0]rs;
logic [31:0]res;
logic [31:0] rm;
logic [4:0] i;
logic [31:0] expected;
logic [31:0] test[26:0];


multiplier dut(
	.Rs(rs),
	.Rm(rm),
	.result(res)
	);

initial 
	begin
		$readmemb("opTest.txt",test);
		i=0;
	end
always
	begin
		rm = test[i];
		rs = test[i+1];
		expected = test[i+2];
		#50;
		if(res==expected)
			begin
				$display("The result of %d * %d is = %d",rm,rs,res);
			end
		else
			begin
				$display("Error occur in op %d * %d",rm,rs);
			end
		i= i+3;
		if(i==24)
			begin 
				$stop;
			end
	end 
endmodule
