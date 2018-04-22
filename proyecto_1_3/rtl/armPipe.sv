module armPipe();

	reg[31:0] instr;
	reg[4:0] iType;
	
	instr_decode InstructionDecoder(
								.ir(instr),
								
								.iType(iType)			
								
								);
endmodule
