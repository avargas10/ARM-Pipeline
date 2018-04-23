/**
* Instituto Tecnologico de Costa Rica
* @author Victor Chavarria Fernadez, Jeison Melendez Arrieta, Andres Vargas Rivera
* Proyecto 1
* Arquitectura de Computadores I
*/
module data_Mem(data_address,in_data,out_data,read_enable,write_enable,clk,isByte,outImage);
parameter data_width = 8;
parameter N =32;
parameter addr_width = 10;

reg [data_width-1:0] M [2**13-1:0]; //Memoria de datos
input [N-1 :0] data_address; //Direccion del datos
//Flags de control
input read_enable;
input write_enable;
input clk;
input isByte;
output logic [7:0] outImage [2500-1:0];

assign outImage = M[2600-1:100];

output reg [N-1:0] out_data; //Datos de salida
input [N-1 :0] in_data; //Datos de entrada
initial begin
		$readmemb("image.txt",M,100); //Imagenes a utilizar
		$readmemh("kernels.txt", M,0,44) ; //kernels (filtros)
end
always @ (posedge read_enable, posedge write_enable)
begin
	if(read_enable)	begin
		out_data = M[data_address];
	end

	else if(write_enable)
	begin
		M[data_address]= in_data;
		$display("mem is %0d in %0d",in_data,data_address);
	end
end

endmodule
