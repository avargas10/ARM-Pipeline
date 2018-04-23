/**
* Instituto Tecnologico de Costa Rica
* @author Victor Chavarria Fernadez, Jeison Melendez Arrieta, Andres Vargas Rivera
* Proyecto 1
* Arquitectura de Computadores I
*/
module instr_Mem(PC,instr,read_enable,clk);
parameter addr_size = 8;
reg [31:0] ram [255:0]; //Memoria de instrucciones
input read_enable; //Flag lectura
input [31:0]PC; //Puntero registro pc
input clk;
output reg [31:0] instr; //Instruccion de salida

initial begin
	$readmemb("code_Mem.txt",ram); //Carga las instrucciones a memoria
	//$readmemb("convolution_Mem.txt",ram); //Carga las instrucciones a memoria
end


always @ (negedge clk)
begin
	if(read_enable==1) begin
		instr= ram[PC[addr_size+1:2]];
	end
end

endmodule
