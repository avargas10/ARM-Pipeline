/**
* Instituto Tecnologico de Costa Rica
* @author Victor Chavarria Fernadez, Jeison Melendez Arrieta, Andres Vargas Rivera
* Proyecto 1
* Arquitectura de Computadores I
*/
//This module decides if a particticular instruction satisfies conditions or not

module evaluator(nzcv,  codeCond, isExecuted);
input logic[3:0] nzcv;
input logic[3:0] codeCond;
output logic isExecuted;

always @* begin

case(codeCond)
	0: begin	//EQ
	if(nzcv[2] == 1)  isExecuted = 1;
	else isExecuted = 0;
	end

	1: begin //NE
	if(nzcv[2] == 0)  isExecuted = 1;
	else isExecuted = 0;
	end

	2: begin //CS
	if(nzcv[1] == 1)  isExecuted = 1;
	else isExecuted = 0;
	end

	3: begin //CC
	if(nzcv[1] == 0)  isExecuted = 1;
	else isExecuted = 0;
	end

	4: begin //MI
	if(nzcv[3] == 1)  isExecuted = 1;
	else isExecuted = 0;
	end

	5: begin //PL
	if(nzcv[3] == 0)  isExecuted = 1;
	else isExecuted = 0;
	end

	6: begin //VS
	if(nzcv[0] == 1)  isExecuted = 1;
	else isExecuted = 0;
	end

	7: begin //VC
	if(nzcv[0] == 0)  isExecuted = 1;
	else isExecuted = 0;
	end

	8: begin //HI
	if(nzcv[1] == 1 && nzcv[2] == 0)  isExecuted = 1;
	else isExecuted = 0;
	end

	9: begin //LS
	if(nzcv[1] == 0 && nzcv[2] == 1)  isExecuted = 1;
	else isExecuted = 0;
	end

	10: begin //GE
	if(nzcv[3] == nzcv[0])  isExecuted = 1;
	else isExecuted = 0;
	end

	11: begin //LT
	if(nzcv[3] != nzcv[0])  isExecuted = 1;
	else isExecuted = 0;
	end

	12: begin //GT
	if(nzcv[2] == 0 && nzcv[3] == nzcv[0])  isExecuted = 1;
	else isExecuted = 0;
	end

	13: begin //LE
	if(nzcv[2] == 0 || nzcv[3] != nzcv[0])  isExecuted = 1;
	else isExecuted = 0;
	end

	14: begin //AL
	isExecuted = 1;
	end

	15: begin //reserved
	isExecuted = 1;
	end

endcase


end

endmodule
