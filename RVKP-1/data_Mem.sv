module data_Mem(data_address,in_data,out_data,read_enable,write_enable,clk,isByte);
parameter data_width = 8;	
parameter N =32;
parameter addr_width = 10;

reg [data_width-1:0] M [2**13-1:0];	
input [N-1 :0] data_address;
input read_enable;
input write_enable;
input clk;
input isByte;

output reg [N-1:0] out_data;
input [N-1 :0] in_data;
initial begin
		$readmemb("image.txt",M,45,2544);
		$readmemh("kernels.txt", M,0,44) ;
end
always @ (posedge read_enable, posedge write_enable)
begin
	if(read_enable)	begin
		out_data = M[data_address];
	end	
	
	else if(write_enable)
	begin
		M[data_address]= in_data;
	end
end

endmodule