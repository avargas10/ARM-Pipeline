`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: Montvydas Klumbys 
// 
// Create Date:    
// Design Name: 
// Module Name:    MainActivity 
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
module MainActivity(
   input CLK,	//clock signal
   input [7:0] image [2500-1:0],
   output [7:0] COLOUR_OUT,//bit patters for colour that goes to VGA port
   output HS,					//Horizontal Synch signal that goes into VGA port
   output VS,	//Vertical Synch signal that goes into VGA port
	output VGA_SYNC,
	output VGA_BLANK
	);
	
	reg DOWNCOUNTER = 0;		//need a downcounter to 25MHz
	//parameter Mickey = 13'd6960;	//overall there are 6960 pixels
	parameter Gimpy = 13'd50625;	//overall there are 6400 pixels
	parameter GimpyXY = 7'd225;	//Gimp has 80x80 pixels
	//parameter MickeyX = 7'd80;	//Mickey has 80 pixels in X direction
	//parameter MickeyY = 7'd87;	//Mickey has 87 pixels in Y direction
	
	//Downcounter to 25MHz		
	always @(posedge CLK)begin     
		DOWNCOUNTER <= ~DOWNCOUNTER;	//Slow down the counter to 25MHz
	end
	
	reg [7:0] COLOUR_IN;
	reg [7:0] COLOUR_DATA [0:Gimpy-1];
	wire [12:0] STATE;
	wire TrigRefresh;			//Trigger gives a pulse when displayed refreshed
	wire [9:0] ADDRH;			//wire for getting Horizontal pixel value
	wire [8:0] ADDRV;			//wire for getting vertical pixel value
	
	//VGA Interface gets values of ADDRH & ADDRV and by puting COLOUR_IN, gets valid output COLOUR_OUT
	//Also gets a trigger, when the screen is refreshed
	VGAInterface VGA(
				.CLK(CLK),
			   .COLOUR_IN (COLOUR_IN),
				.COLOUR_OUT(COLOUR_OUT),
				.HS(HS),
				.VS(VS),
				.REFRESH(TrigRefresh),
				.ADDRH(ADDRH),
				.ADDRV(ADDRV),
				.DOWNCOUNTER(DOWNCOUNTER)
				);
	reg signed [10:0]X = 10'd280;
	reg signed [9:0]Y = 9'd200;

	reg signed [4:0] ZeroX = -3;
	reg signed [4:0] ZeroY = -3;
	reg [3:0]Speed = 3;
	
	assign VGA_SYNC=1'b0;
	assign VGA_BLANK = VS & HS;

	always @(posedge CLK) begin 
		if (TrigRefresh) begin
				if (639 <= X + 80+5)  //iif RIGTH wall was reached
					ZeroX <= -Speed;	//change the direction
				if (5 >= X)	//the same for the LEFT, UPPER & LOWER walls
					ZeroX <= Speed;
				if (479 <= Y + 80+5)
					ZeroY <= -Speed;
				if (5 >= Y)
					ZeroY <= Speed;
			
				X <= X + ZeroX;				// Get a new position every frame
				Y <= Y + ZeroY;
		end
	end

	initial
	$readmemb ("image.txt", COLOUR_DATA);
	

	assign STATE = ADDRH + ADDRV*GimpyXY;
	always @(posedge CLK) begin
		if (ADDRV < GimpyXY && ADDRH < GimpyXY)begin
			COLOUR_IN <= COLOUR_DATA[{STATE}];
		end
		else COLOUR_IN <= 8'h87;
	end
	
endmodule