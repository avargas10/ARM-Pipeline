/**
* Instituto Tecnologico de Costa Rica
* @author Victor Chavarria Fernadez, Jeison Melendez Arrieta, Andres Vargas Rivera
* Proyecto 1
* Arquitectura de Computadores I
*/
`timescale 1ns/1ns
//Archivo de prueba memoria de datos
module dataMemTB();
logic [31:0]address;
logic [31:0]in;
logic [31:0]out;
logic re;
logic we;
logic clock;
logic isB;
logic [31:0] test[26:0];

data_Mem memory(
    .data_address(address),
    .in_data(in),
    .out_data(out),
    .read_enable(re),
    .write_enable(we),
    .clk(clock),
    .isByte(isB));


initial
	begin
		$readmemb("opTest.txt",test);
		clock=0;
        address=0;
        isB=0;
        we=1;
        re=0;
        in = test[address];
    end
always@(posedge clock)
    begin
        address++;
        in = test[address];
        $display("Writing %d in address %d",in,address);
        if (address>=8  )
            begin
                $stop;
            end
    end
always
	begin
		clock<=1; #100;
		clock<=0; #100;
	end
endmodule
