`define AND 4'd0
`define EOR 4'd1
`define SUB 4'd2
`define RSB 4'd3
`define ADD 4'd4
`define ADC 4'd5
`define SBC 4'd6
`define RSC 4'd7
`define TST 4'd8
`define TEQ 4'd9
`define CMP 4'd10
`define CMN 4'd11
`define ORR 4'd12
`define MOV 4'd13
`define BIC 4'd14
`define MVN 4'd15
//reference: http://www.cc.gatech.edu/~hyesoon/spr10/lec_arm2.pdf , page 6
module ALU(opcode, op1, op2, res, nzcv_old, nzcv, cFlag, isWriteback);

parameter N = 32; 

input[3:0] opcode;	//opcode of operation
input logic [N-1:0] op1; //operands:
input logic [N-1:0] op2;
input logic [3:0] nzcv_old; //old nzcv
input logic cFlag;//this is carry flag from shifter. so that we can update carry flag for logical instructions

output logic isWriteback; //specifies if res is to be written back
output logic [N-1:0] res; //output
output logic [3:0] nzcv; 	//update nzcv register
/*condition code register.  i.e, both read and write,  nzcv[3] = n
nzcv[0] = v
nzcv[1] = c
nzcv[2] = z
nzcv[3] = n  */

logic inData;
logic outData;
logic[N-1:0] neg;

always @(*) begin
	nzcv= nzcv_old;

	case(opcode)
		//logical and
		`AND: begin
			res = op1 & op2;
			nzcv[1] = cFlag;
			isWriteback = 1;
		end
		//xor
		`EOR: begin
			res = op1 ^ op2;
			isWriteback = 1;
			nzcv[1] = cFlag;
		end
		//res = op1-op2
		`SUB: begin
			neg = -op2;
			{inData, res[N-2:0]} = op1[N-2:0]+neg[N-2:0]; 
			{outData, res[N-1]} = inData+ op1[N-1]+neg[N-1];
			nzcv[1]  = outData;	//carry flag
			nzcv[0] = inData^outData; //overflow flag
			isWriteback = 1;
		end
		
		//res = op2-op1
		`RSB: begin
			neg = -op1;
			{inData, res[N-2:0]} = op2[N-2:0]+neg[N-2:0]; 
			{outData, res[N-1]} = inData+ op2[N-1]+neg[N-1];
			nzcv[1]  = outData;	//carry flag
			nzcv[0] = inData^outData; //overflow flag
			isWriteback = 1;
		end
		
		//res = op1+op2
		`ADD: begin
			{inData, res[N-2:0]} = op1[N-2:0]+op2[N-2:0]; 
			{outData, res[N-1]} = inData+ op1[N-1]+op2[N-1];
			nzcv[1]  = outData;	//carry flag
			nzcv[0] = inData^outData; //overflow flag
			isWriteback = 1;
		end
		
		//res = op1+op2+c
		`ADC: begin
			{inData, res[N-2:0]} = op1[N-2:0]+op2[N-2:0]+nzcv_old[1]; 
			{outData, res[N-1]} = inData+ op1[N-1]+op2[N-1];
			nzcv[1]  = outData;	//carry flag
			nzcv[0] = inData^outData; //overflow flag
			isWriteback = 1;
		end
		
		//res = op1 – Op2 + C-1
		`SBC: begin
			neg = -op2;
			{inData, res[N-2:0]} = op1[N-2:0]+neg[N-2:0]+nzcv_old[1]-1; 
			{outData, res[N-1]} = inData+ op1[N-1]+neg[N-1];
			nzcv[1]  = outData;	//carry flag
			nzcv[0] = inData^outData; //overflow flag	
			isWriteback = 1;
		end
		
		//res = op2-op1+c-1
		`RSC: begin
			neg = -op1;
			{inData, res[N-2:0]} = op2[N-2:0]+neg[N-2:0]+nzcv_old[1]-1; 
			{outData, res[N-1]} = inData+ op2[N-1]+neg[N-1];
			nzcv[1]  = outData;	//carry flag
			nzcv[0] = inData^outData; //overflow flag
			isWriteback = 1;
		end
		
		//same as AND  but you don't write back
		`TST: begin
			res = op1 & op2;
			isWriteback = 0;
			nzcv[1] = cFlag;
		end
		
		//same as EOR but you don't write back
		`TEQ: begin
			res = op1 ^ op2;
			isWriteback = 0;
			nzcv[1] = cFlag;
		end
		
		//same as SUB but you don't write back
		`CMP: begin
			neg = -op2;
			{inData, res[N-2:0]} = op1[N-2:0]+neg[N-2:0]; 
			{outData, res[N-1]} = inData+ op1[N-1]+neg[N-1];
			nzcv[1]  = outData;	//carry flag
			nzcv[0] = inData^outData; //overflow flag
			isWriteback = 0;
		end
		
		//same as ADD but you don't write back
		`CMN: begin
			{inData, res[N-2:0]} = op1[N-2:0]+op2[N-2:0]; 
			{outData, res[N-1]} = inData+ op1[N-1]+op2[N-1];
			nzcv[1]  = outData;	//carry flag
			nzcv[0] = inData^outData; //overflow flag
			isWriteback = 0;
		end
		
		//bitwise or
		`ORR: begin
			res = op1 | op2;
			isWriteback = 1;
			nzcv[1] = cFlag;
		end
		
		//move. op1 ignored
		`MOV: begin
			res = op2;
			isWriteback = 1;
			nzcv[1] =cFlag;
		end
		
		//res = op1 & ~op2
		`BIC: begin
			res = op1 & (~op2);
			isWriteback = 1;
			nzcv[1] =cFlag;
		end
		
		//move negated op2
		`MVN: begin
			res = ~op2;
			isWriteback = 1;
			nzcv[1] = cFlag;
		end
		
	endcase

	nzcv[3] = res[N-1]; 	//n flag	
	nzcv[2] = (res == 0); // z flag
			
end

endmodule
