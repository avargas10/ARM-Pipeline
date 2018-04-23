/**
* Instituto Tecnologico de Costa Rica
* @author Victor Chavarria Fernadez, Jeison Melendez Arrieta, Andres Vargas Rivera
* Proyecto 1
* Arquitectura de Computadores I
*/
module armPipe();

	reg[31:0] instr;
	reg[4:0] iType;

	instr_decode InstructionDecoder(
								.ir(instr),

								.iType(iType)

								);
endmodule
