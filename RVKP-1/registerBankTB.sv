`timescale 1ns/1ns

module registerBankTB();
parameter N = 32;
logic [3:0]inA1;
logic [3:0]inA2;
logic [3:0]inA3;
logic [3:0]inA4; 
logic [N-1:0]out1;
logic [N-1:0]out2;
logic [N-1:0]out3;
logic [N-1:0]out4; 
logic [3:0]writeA;
logic [N-1:0]writeD;
logic we;
logic [3:0]writeA2;
logic [N-1:0]writeD2;
logic we2;
logic [N-1:0]PC;
logic [N-1:0]PC_update;
logic PC_write;
logic [N-1:0]CSPR;
logic csprW;
logic [N-1:0]CSPR_update;
logic clock; 


registerBank regFile(
			.in_address1(inA1),
			.in_address2(inA2),
			.in_address3(inA3),
			.in_address4(inA4) ,
			.out_data1(out1),
			.out_data2(out2),
			.out_data3(out3),
			.out_data4(out4) ,
			.write_address(writeA),
			.write_data(writeD),
			.write_enable(we),
			.write_address2(writeA2),
			.write_data2(writeD2),
			.write_enable2(we2),
			.pc(PC),
			.pc_update(PC_update),
			.pc_write(PC_write) ,
			.cspr(CSPR),
			.cspr_write(csprW),
			.cspr_update(CSPR_update),
			.clk(clock) 
	);

initial 
	begin
		clock=0;
		PC =0;
		we = 1;
		we2 = 1;
		writeA = 0;
		writeD = 10;
		inA1= 0;
	end
always@(negedge clock)
	begin
		if(writeA<15)
			begin				
				$display("Writting= %b in reg = %b",writeD,writeA); #100;
				$display("Reading= %b in reg = %b",out1,inA1);
				writeA = writeA+1;
				writeD = writeD+1;
				inA1 = inA1 +1;
			end
		else
			begin
				$stop;
			end
	end
always
	begin
		clock<=1; #10;
		clock<=0; #10;
	end 
endmodule
 