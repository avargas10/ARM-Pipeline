`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date:    21:51:11 10/04/2017 
// Design Name: 
// Module Name:    output_pixels 
// Project Name: 
// Target Devices: 
// Tool versions: 
// Description: 
//
// Dependencies: 
//
// Revision: 
// Revision 0.01 - File Created
// Additional Comments: 
//
//////////////////////////////////////////////////////////////////////////////////
module output_pixels(             
		clk,
		rst,
		hcount,
		vcount,
		out_pixels 
);

// ====================================================================================
// 										Port Declarations
// ====================================================================================
	input 		 clk;
	input 		 rst;
	input	[10:0] hcount;
	input	[9:0]	 vcount;
	output [7:0] out_pixels;

// ====================================================================================
// 								Parameters, Register, and Wires
// ====================================================================================
	reg [7:0]	 out_pixels;
	reg [7:0]	 x = 180;
	reg [7:0]	 y = 245;
	logic [7:0]	DATA [0:50624];
	int  counter=0;
  
//  ===================================================================================
// 							  				Implementation
//  ===================================================================================
		initial
		$readmemh ("image.txt",DATA);
		
		always @(posedge clk)
		begin
			if ( rst == 1 ) begin
				out_pixels <= 0;
				counter <= 0;
			end
		   else
				if(hcount>=200 && hcount <=425 && vcount>=150 && vcount<=375) 
				begin
					if(counter>=50625)
						counter <= 0;
					else begin
						out_pixels <= DATA[counter];
						counter++;
					end
				end
				else
					out_pixels <= 0;
		end
endmodule
