`timescale 1ns/1ns

module instrDecodeTB();
logic[31:0] instr;
wire [3:0] typeI;
logic [31:0] iterator;
logic [31:0] fakeCache [6:0];

initial
	begin
		$readmemb("intr_Cache.txt",fakeCache);
		 iterator = 0;
	end 

instr_decode uut(
		.ir(instr),
		.iType(typeI)
	);



always
	begin
		instr = fakeCache[iterator];
		#100; 
		$display("Instruction = %b",instr);		
		$display("Instruction type = %b",typeI);
		iterator = iterator+1;
		if(iterator==6)begin
		    $stop;
		end
	end 
endmodule
