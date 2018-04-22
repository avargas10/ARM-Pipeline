`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date:    21:39:26 10/04/2017 
// Design Name: 
// Module Name:    xvga 
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
module xvga(
    clk, //100Mhz clk
	vclk, //50Mhz clk 
		rst,
		vsync,
		hsync,
		VGA_R,
		VGA_G,
		VGA_B,
		Blank,
		Sync
);

// ====================================================================================
// 										Inputs Declarations
// ====================================================================================			
	input 		 clk; 
	input 		 rst;
	input 		 vclk;
	output		 vsync;
	output		 hsync;
	output [7:0] VGA_R;
	output [7:0] VGA_G;
	output [7:0] VGA_B;
	output		Blank;
	output		Sync;
   
// ====================================================================================
// 								Parameters, Register, and Wires
// ====================================================================================	
	reg			 vs;
	reg			 hs;
   reg [10:0]	 hcount;
   reg [9:0]	 vcount;
	reg [9:0]	 counter;
   reg 			 hblank;
	reg			 vblank;
   reg			 frame;
	
	///////////////////STATIC POSITIONS DRAW//////////////////////////////////

///////////////////PIXEL POSITIONS DRAW//////////////////////////////////

	wire [7:0] 	 pixel;
	wire [7:0] 	 final_pixels;
	
	///////////////////WIRES TO LINK POSITIONS AND DRAW//////////////////////////////////
	
	
	///////////////////VGA DRAWS//////////////////////////////////
	wire 			 hsyncon;
	wire			 hsyncoff;
	wire			 hreset;
	wire			 hblankon;
	wire			 next_hblank;
	wire			 next_vblank;
	
//  ===================================================================================
// 							  				Implementation
//  ===================================================================================
	
		// horizontal: 1039 pixels total
		// display 800 pixels per line
		assign hblankon = (hcount == 799);    
		assign hsyncon = (hcount == 855);
		assign hsyncoff = (hcount == 975);
		assign hreset = (hcount == 1039);

		// vertical: 665 lines total
		// display 600 lines
		wire vsyncon,vsyncoff,vreset,vblankon;
		assign vblankon = hreset & (vcount == 599);    
		assign vsyncon = hreset & (vcount == 636);
		assign vsyncoff = hreset & (vcount == 642);
		assign Blank = hsync & vsync;
		assign	Sync	=	1'b0;
		assign vreset = hreset & (vcount == 665);
		
  
		// sync and blanking
		assign next_hblank = hreset ? 0 : hblankon ? 1 : hblank;
		assign next_vblank = vreset ? 0 : vblankon ? 1 : vblank;
  	
		always @(posedge clk) 
		begin
			if (rst == 1)  
			begin
				hcount <= 0;
				vcount <= 0;
				vs <= 1;
				hs <= 1;
				vblank <= 0;
				hblank <= 0;
				counter <= 0;
				frame <= 0;
			end
			else 
			begin
				if ( vclk == 1 ) 
				begin
					hcount <= hreset ? 0 : hcount + 1;
					hblank <= next_hblank;
					hs <= hsyncon ? 0 : hsyncoff ? 1 : hs;  // active low
					vcount <= hreset ? (vreset ? 0 : vcount + 1) : vcount;
					vblank <= next_vblank;
					vs <= vsyncon ? 0 : vsyncoff ? 1 : vs;  // active low
      
					if ( vs == 0 )
						counter <= counter + 1;
						
					if ( counter ==  600) 
					begin
						counter <= 0;
						frame <= 1;
					end
					else
						frame <= 0;
				end
			end
		end

		//-------------------------------------------------------------------------
		//		 							Draw
		//-------------------------------------------------------------------------


		//-------------------------------------------------------------------------
		//		 							Final outputs WIN or LOOSE
		//-------------------------------------------------------------------------
		output_pixels final_out(
			 .clk(vclk),
			 .rst(rst),			 
			 .hcount(hcount),
			 .vcount(vcount),
			 .out_pixels(final_pixels)
		);

		
		assign pixel = final_pixels;
		assign VGA_R = pixel;
		assign VGA_G = pixel;
		assign VGA_B = pixel;
		assign vsync = ~vs;
		assign hsync = ~hs;


endmodule
