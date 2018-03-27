`define multiply			0
`define multiplyLong		1
`define branchAndExchange	2
`define SingleDataSwap		3
`define HalfwordDataTransferR	4
`define HalfwordDataTransferI	5
`define signedDataTransfer	6
`define dataProcessing		7
`define loadStoreUnsigned			8
`define undefined			9
`define blockDataTransfer	10
`define branch				11
`define coprocessor			12

module inst_decode(ir, type1);
input wire [31:0] ir;
output reg[3:0] type1;

initial begin
	type1 = `undefined;
end

//decoding tree done by Bhanu _/\_
always@* begin
	if(ir[27] == 1 && ir[26] ==1) type1 = `coprocessor;
	
	if(ir[27] == 1 && ir[26] == 0) begin
		if(ir[25] == 0) type1 = `blockDataTransfer;
		else if(ir[25] == 1) type1 = `branch;
	end
	
	if(ir[27] == 0 && ir[26] == 1) begin
		if(ir[25] == 0) type1 = `loadStoreUnsigned;
		else begin
			if(ir[4] == 1) type1 = `undefined;
			if(ir[4] == 0) type1 = `loadStoreUnsigned;
		end
	end
	
	if(ir[27] == 0 && ir[26] == 0) begin
		if(ir[25] == 1) type1 = `dataProcessing;
		
		else begin
			if(ir[11:8] == 4'b1111 && ir[7:4] == 4'b0001) type1 = `branchAndExchange;
			
			else if( (( ir[7] ==1) && (ir[4] == 1)) == 0) type1 = `dataProcessing;
			
			else if( ir[6] == 1) type1 = `signedDataTransfer;
			
			else if( ir[6] == 0 && ir[5] == 1 && ir[22] == 1) type1 = `HalfwordDataTransferI;
		
			else if( ir[6] == 0 && ir[5] == 1 && ir[22] == 1) type1 = `HalfwordDataTransferR;
	
			else if( ir[6] == 0 && ir[5] == 0 && ir[24] == 1) type1 = `SingleDataSwap;
	
			else if( ir[6] == 0 && ir[5] == 0 && ir[24] == 0 && ir[23] ==1) type1 = `multiplyLong;
			
			else if( ir[6] == 0 && ir[5] == 0 && ir[24] == 0 && ir[23] ==0) type1 = `multiply;
		end
	end


end
endmodule
