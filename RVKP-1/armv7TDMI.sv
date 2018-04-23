/**
* Instituto Tecnologico de Costa Rica
* @author Victor Chavarria Fernadez, Jeison Melendez Arrieta, Andres Vargas Rivera
* Proyecto 1
* Arquitectura de Computadores I
*/
`timescale 1ns/1ns

module armv7TDMI();
logic clock;

pipeline micro(
    .clk(clock));

initial
	begin
		clock=0;
    end
always
	begin
		clock<=1; #50;
		clock<=0; #50;
	end
endmodule
