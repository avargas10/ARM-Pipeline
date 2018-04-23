/**
* Instituto Tecnologico de Costa Rica
* @author Victor Chavarria Fernadez, Jeison Melendez Arrieta, Andres Vargas Rivera
* Proyecto 1
* Arquitectura de Computadores I
*/
//Usado para instrucciones de procesamiento de datos y algunas otro tipo de instrucciones que necesiten shift

module shift(instr_bit_25,imm_value, Rm, Rs, operand2, cin, c_to_alu, direct_data, use_shifter);
	parameter n=32;
	input [n-1:0] direct_data;
	input use_shifter;
	input instr_bit_25; // bit no. 25 en la instr
	input [11:0] imm_value; // bits 11-0 en instr
	input [n-1:0] Rm;
	input [n-1:0] Rs;
	output [n-1:0] operand2; // operand 2 for ALU
	input cin;
	output logic c_to_alu;

	logic instr_bit_25;
	logic [11:0] imm_value;
	logic [n-1:0] in;
	logic [n-1:0] out;
	logic [7:0] shiftby; // no. bits a realizar el shifted
	logic [n-1:0] junk;

	assign operand2 =(use_shifter==1)?out:direct_data ;

	always @* begin

		if (instr_bit_25) begin
			//rotacion a la derecha de extension de cero del imm de 8 bits por 2*rot
			//rot=4 bits MSB del imm
			in[n-1:8] = 0;
			in[7:0] = imm_value[7:0];
			//shiftby*2
			shiftby[0]=0;
			shiftby[7:4]=4'd0;
			shiftby[4:1] = imm_value[11:8];
			//shifting
			{junk,out} = {in,in} >> shiftby[7:0];
			if(shiftby[7:0]==0) c_to_alu = cin;
			else c_to_alu = out[31];
		end

		else begin
			// Desplazamiento logico a la izquierda por inmediato
			if(imm_value[6:4] == 0) begin
				in = Rm;
				{c_to_alu,out} = {cin ,in} << imm_value[11:7];
				// C flag
			end
			// Desplazamiento logico a la izquierda por registro
			if(imm_value[6:4] == 3'd1) begin
				in = Rm;
				shiftby[7:0] = Rs[7:0];
				{c_to_alu,out} = {cin,in} << shiftby[7:0];

			end

			// Desplazamiento logico a la derecha por inmediato
			if(imm_value[6:4] == 3'd2) begin
				in = Rm;
				{out, c_to_alu} = {in,cin} >> imm_value[11:7];

			end

			// Desplazamiento logico a la derecha por registro
			if(imm_value[6:4] == 3'd3) begin
				in = Rm;
				shiftby[7:0] = Rs[7:0];
				{out, c_to_alu} = {in,cin} >> shiftby[7:0];

			end

			//Desplazamiento aritmetico a la izquierda por registro
			if(imm_value[6:4] == 3'd4) begin
				in = Rm;
				//out[7] = in[7]; // preserves sign
				if(in[n-1]){junk,out, c_to_alu} = {32'hFFFFFFFF,in,cin} >> imm_value[11:7];
				else {out, c_to_alu} = {in,cin} >> imm_value[11:7];
			end

			//Desplazamiento aritmetico a la derecha por registro
			if(imm_value[6:4] == 3'd5) begin
				in = Rm;
				shiftby[7:0] = Rs[7:0];
				if(in[n-1]) {junk,out, c_to_alu} = {32'hFFFFFFFF,in,cin} >> shiftby[7:0];
				else {out,c_to_alu} = {in,cin} >> shiftby[7:0];
			end

			// Rotacion derecha por inmediato
			if((imm_value[6:4] == 3'd6)&&(imm_value[11:7]!=5'd0)) begin
				in = Rm;
				{junk,out,c_to_alu} = {in,in,cin} >> imm_value[11:7];
			end

			//Rotacion derecha por Registro
			if(imm_value[6:4] == 3'd7) begin
				in=Rm;
				shiftby[7:0] = Rs[7:0];
				{junk,out,c_to_alu} = {in,in,cin} >> shiftby[4:0]; // [4:0] because.. if input is given as 100 it is enough to shift with 4 .. i.e 100mod 32
			end

			// RRX

			if((imm_value[6:4] == 3'd6)&&(imm_value[11:7]==5'd0)) begin
				in= Rm;
				{out, c_to_alu} = {cin, in};
			end

		end
	end
endmodule
