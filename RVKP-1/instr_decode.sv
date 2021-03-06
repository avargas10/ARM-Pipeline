/**
* Instituto Tecnologico de Costa Rica
* @author Victor Chavarria Fernadez, Jeison Melendez Arrieta, Andres Vargas Rivera
* Proyecto 1
* Arquitectura de Computadores I
*/
//Constantes
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

module instr_decode(ir, iType);
input logic [31:0] ir;
output logic[3:0] iType;

initial begin
	iType = `undefined; //Tipo de la instruccion
end

always@* begin
	if(ir[27] == 1 && ir[26] ==1) iType = `coprocessor;

	if(ir[27] == 1 && ir[26] == 0) begin
		if(ir[25] == 0) iType = `blockDataTransfer;
		else if(ir[25] == 1) iType = `branch;
	end

	if(ir[27] == 0 && ir[26] == 1) begin
		if(ir[25] == 0) iType = `loadStoreUnsigned;
		else begin
			if(ir[4] == 1) iType = `undefined;
			if(ir[4] == 0) iType = `loadStoreUnsigned;
		end
	end

	if(ir[27] == 0 && ir[26] == 0) begin
		if(ir[25] == 1) iType = `dataProcessing;

		else begin
			if(ir[11:8] == 4'b1111 && ir[7:4] == 4'b0001) iType = `branchAndExchange;

			else if( (( ir[7] ==1) && (ir[4] == 1)) == 0) iType = `dataProcessing;

			else if( ir[6] == 1) iType = `signedDataTransfer;

			else if( ir[6] == 0 && ir[5] == 1 && ir[22] == 1) iType = `HalfwordDataTransferI;

			else if( ir[6] == 0 && ir[5] == 1 && ir[22] == 1) iType = `HalfwordDataTransferR;

			else if( ir[6] == 0 && ir[5] == 0 && ir[24] == 1) iType = `SingleDataSwap;

			else if( ir[6] == 0 && ir[5] == 0 && ir[24] == 0 && ir[23] ==1) iType = `multiplyLong;

			else if( ir[6] == 0 && ir[5] == 0 && ir[24] == 0 && ir[23] ==0) iType = `multiply;
		end
	end


end
endmodule
