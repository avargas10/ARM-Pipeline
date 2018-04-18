// Top module
`define multiply				0
`define multiplyLong			1
`define branchAndExchange		2
`define SingleDataSwap			3
`define HalfwordDataTransferR	4
`define HalfwordDataTransferI	5
`define signedDataTransfer		6
`define dataProcessing			7
`define loadStoreUnsigned		8
`define undefined				9
`define blockDataTransfer		10
`define branch					11
`define coprocessor				12
`define ADD 4'd4
`define SUB 4'd2


module pipeline(input clk);

/******************
*
* F: Instruction Fetch and decode
*
******************/



logic[31:0] current_pc;
logic[31:0] pc;
logic[31:0] instr;
logic fetch_instr;
logic[3:0] itype;
instr_Mem instrCache(
                    //in
						.PC(current_pc),//
						.read_enable(fetch_instr),
						.clk(clk),
							
					//out
						.instr(instr)		
							);

instr_decode Decoder(
                    .ir(instr),
                    .iType(itype)			
                        );

/*******F/R*****/
logic[31:0] F_R_instr; // = instr in always
logic[3:0] F_R_type;		//= type
logic F_R_flush;

/******************
*
* R: Register Read (RegisterFile access)
*
******************/

logic[31:0] out_data_1;
logic[31:0] out_data_2;
logic[31:0] out_data_3;
logic[31:0] out_data_4;
logic[31:0] operand_2;
logic[31:0] cspr;


logic[3:0] read_address; //have to change based on instruction

//For writeback.
logic[3:0] write_address;
logic[31:0] write_data;
logic write_enable;
logic[3:0] write_address_2;
logic[31:0] write_data_2;
logic write_enable_2;
logic[31:0] pc_update;
logic pc_write;
logic cspr_write;
logic[31:0] cspr_update;
//



registerBank regs(	
                    //in\
                        .in_address1(F_R_instr[19:16]),
                        .in_address2(F_R_instr[15:12]),
                        .in_address3(F_R_instr[11:8]),
                        .in_address4(F_R_instr[3:0]),
                        .write_address(write_address),
                        .write_address2(write_address_2),							
                        .write_data(write_data),
                        .write_data2(write_data_2),
                        .write_enable(write_enable),
                        .write_enable2(write_enable_2),
                        .pc_update(pc_update), 
                        .pc_write(pc_write), 
                        .cspr_write(cspr_write), 
                        .cspr_update(cspr_update),
                        .clk(clk), 
                        
                    //out
                        .out_data1(out_data_1),
                        .out_data2(out_data_2),
                        .out_data3(out_data_3),
                        .out_data4(out_data_4),
                        //s.universal_out_data(),
                        .pc(pc), 
                        .cspr(cspr)			
                        );

/*******R/MUL*****/
logic[3:0] R_MUL_type;			//= F_R_type
logic[31:0] R_MUL_instr;			//=F_R_instr
logic[31:0] R_MUL_out_data_1;	//=out_data_1
logic[31:0] R_MUL_out_data_2;	//=out_data_2
logic[31:0] R_MUL_out_data_3;	//=out_data_3
logic[31:0] R_MUL_out_data_4;	//=out_data_4
logic R_MUL_flush;

/******************
*
* MUL : Multiply (Multiply)
*
******************/

logic[31:0] mult_result;
logic[3:0] mult_nzcv;


multiplier mult(
							.Rs(R_MUL_out_data_3), 
							.Rm(R_MUL_out_data_4),
							
							.result(mult_result)

							);


/*******MUL/ALU*****/
logic[3:0] MUL_ALU_type;			//= //= make this 'nop' of condchecker says it will not be executed else, MUL_ALU_type
logic[31:0] MUL_ALU_instr;		//=R_MUL_instr
logic[31:0] MUL_ALU_out_data_1;	//=R_MUL_out_data_1
logic[31:0] MUL_ALU_out_data_2;	//=R_MUL_out_data_2
logic[31:0] MUL_ALU_out_data_3;	//=R_MUL_out_data_3
logic[31:0] MUL_ALU_out_data_4;	//=R_MUL_out_data_4
logic [31:0] MUL_ALU_mult_result;	// = mult_result
logic MUL_ALU_will_this_be_executed;	//=will this be executed
logic MUL_ALU_c_update; 	//= c_update
logic MUL_ALU_c_write;	// = c_write
logic MUL_ALU_flush;
/******************
*
* ALU : ALU (Barrel shifter, ALU and condition code checker.)
*
******************/


logic[31:0] alu_result;
logic[3:0] alu_nzcv;
logic alu_is_writeback;
logic will_this_be_executed;

logic c_to_alu;
logic[31:0] shifter_result;

logic[3:0] nzcv_forward;	//connected to alu. fed from alu.

logic use_shifter;
logic[31:0] alu_operand_1;
logic[31:0] alu_operand_2;
logic[3:0] alu_opcode;


shift Shifter(		
							.instr_bit_25(MUL_ALU_instr[25]),
							.imm_value(MUL_ALU_instr[11:0]), 
							.Rs(MUL_ALU_out_data_3), 
							.Rm(MUL_ALU_out_data_4), 
							.cin(nzcv_forward[1]),
							.direct_data(alu_operand_2),
							.use_shifter(use_shifter),

							
							.operand2(shifter_result), 
							.c_to_alu(c_to_alu)
							
							);

ALU alu(
							.opcode(alu_opcode), 
							.op1(alu_operand_1), 
							.op2(shifter_result), 
							.nzcv_old(nzcv_forward), //I have forwarded this from result of alu itself
							.cFlag(c_to_alu), 					
							.res(alu_result), 
							.nzcv(alu_nzcv), 
							.isWriteback(alu_is_writeback)
							);

evaluator instrCheck(
					.nzcv(alu_nzcv),	//we check for condition right after calculation of nzcv flags. Check this with previous instruction.
					.codeCond(R_MUL_instr[31:28]),//i.e  with instruction from previous pipeline
					.isExecuted(will_this_be_executed)						
							);

/*******ALU/MEM*****/
logic ALU_MEM_will_this_be_executed;	//=MEM
logic[3:0]  ALU_MEM_type;			
logic[31:0] ALU_MEM_instr;			//
logic[31:0] ALU_MEM_out_data_1;	//=
logic[31:0] ALU_MEM_out_data_2;	//=
logic[31:0] ALU_MEM_out_data_3;	//=
logic[31:0] ALU_MEM_out_data_4;	//=
logic [31:0] ALU_MEM_mult_result;	// = MUL_ALU_mult_result
logic [31:0] ALU_MEM_alu_result;	// = alu_result
logic [3:0] ALU_MEM_alu_nzcv;		// = alu_nzcv
logic ALU_MEM_alu_is_writeback;	//  = alu_is_writeback
logic ALU_MEM_flush;
//nzcv_forward = alu_nzcv;

/******************
*
* MEM: Memory (Memory access)
*
******************/
logic[31:0] memory_out_data;
logic[31:0] memory_data_address;
logic[31:0] memory_in_data;
logic memory_write_enable;
logic memory_read_enable;
logic isByte;

data_Mem DataCache(
							.data_address(memory_data_address),
							.in_data(memory_in_data),
							.read_enable(memory_read_enable),
							.write_enable(memory_write_enable),
							.isByte(isByte),
							.clk(clk),							
							.out_data(memory_out_data)
							);

/*******MEM/W*****/
logic MEM_W_will_this_be_executed; //
logic[3:0]  MEM_W_type;			//= ALU_MEM_type
logic[31:0] MEM_W_instr;			//
logic[31:0] MEM_W_out_data_1;		//=
logic[31:0] MEM_W_out_data_2;		//=
logic[31:0] MEM_W_out_data_3;		//=
logic[31:0] MEM_W_out_data_4;		//=
logic[31:0] MEM_W_memory_out_data;//= 
logic [31:0] MEM_W_mult_result;	// = ALU_MEM_mult_result
logic [31:0] MEM_W_alu_result;
// = ALU_MEM_alu_result
logic [3:0] MEM_W_alu_nzcv;		// = ALU_MEM_alu_nzcv
logic MEM_W_alu_is_writeback;		//  = ALU_MEM_alu_is_writeback
logic MEM_W_flush;

/******************
*
* W: Writeback (To RegisterFile and PC)
*
******************/
/*For reference
logic[3:0] write_address;
logic[31:0] write_data;
logic write_enable;
logic[31:0] pc_update;
logic pc_write;
logic cspr_write;
logic[31:0] cspr_update;
*/

logic want_to_flush;
logic number_stalls;

initial begin
	//Fill alu with nops at the beginning.
	current_pc  = 0;
	pc_update = 0;
	F_R_type = `undefined;
	R_MUL_type = `undefined;
	MUL_ALU_type = `undefined;
	ALU_MEM_type = `undefined;
	MEM_W_type = `undefined;
	cspr_update = 0;
	nzcv_forward = 0;
	want_to_flush = 0;
	number_stalls = 0;
end

/*
//Fetch
always@(posedge clk) begin
	//fetch instruction.
	fetch_instr = 1; 
end*/


//Register Read

//forward registers:
logic[31:0] out_data_1_fwd;
logic out_data_1_use_fwd;
logic[31:0] out_data_2_fwd;
logic out_data_2_use_fwd;
logic[31:0] out_data_3_fwd;
logic out_data_3_use_fwd;
logic[31:0] out_data_4_fwd;
logic out_data_4_use_fwd;

logic[31:0] MUL_ALU_data_1_fwd;
logic MUL_ALU_data_1_use_fwd;
logic[31:0] MUL_ALU_data_2_fwd;
logic MUL_ALU_data_2_use_fwd;
logic[31:0] MUL_ALU_data_3_fwd;
logic MUL_ALU_data_3_use_fwd;
logic[31:0] MUL_ALU_data_4_fwd;
logic MUL_ALU_data_4_use_fwd;

//data dependency. and forwarder
always@(*) begin
	/*This block generates control signals that there might be dependency. This will be used in each block only if that instruction is executed.
	Fetch
	Register read
	MUL
	ALU
	MEM
	WB
	*/

	out_data_1_use_fwd =0;
 	out_data_2_use_fwd =0;
	out_data_3_use_fwd =0;
	out_data_4_use_fwd =0;
	MUL_ALU_data_1_use_fwd =0;
 	MUL_ALU_data_2_use_fwd =0;
	MUL_ALU_data_3_use_fwd =0;
	MUL_ALU_data_4_use_fwd =0;
	//operands used: [19:16], [15:12] [11:8], [3:0]
	//From WB stage
	if(write_enable == 1) begin
		if(F_R_instr[19:16] == write_address) begin
			out_data_1_fwd = write_data;
			out_data_1_use_fwd = 1;
		end
		if(F_R_instr[15:12] == write_address) begin
			out_data_2_fwd = write_data;
			out_data_2_use_fwd = 1;
		end
		if(F_R_instr[11:8] == write_address) begin
			out_data_3_fwd = write_data;
			out_data_3_use_fwd = 1;
		end
		if(F_R_instr[3:0] == write_address) begin
			out_data_4_fwd = write_data;
			out_data_4_use_fwd = 1;
		end
	end

	if(write_enable_2 == 1) begin
		if(F_R_instr[19:16] == write_address_2) begin
			out_data_1_fwd = write_data_2;
			out_data_1_use_fwd = 1;
		end
		if(F_R_instr[15:12] == write_address_2) begin
			out_data_2_fwd = write_data_2;
			out_data_2_use_fwd = 1;
		end
		if(F_R_instr[11:8] == write_address_2) begin
			out_data_3_fwd = write_data_2;
			out_data_3_use_fwd = 1;
		end
		if(F_R_instr[3:0] == write_address_2) begin
			out_data_4_fwd = write_data_2;
			out_data_4_use_fwd = 1;
		end
	end

	//From Mem stage
	if(ALU_MEM_type == `loadStoreUnsigned && ALU_MEM_will_this_be_executed == 1) begin
		
		if(ALU_MEM_instr[20]==1) begin 	//Load from memory
			if(F_R_instr[19:16] == ALU_MEM_instr[15:12] ) begin
				out_data_1_fwd = memory_out_data;
				out_data_1_use_fwd = 1;
			end
			if(F_R_instr[15:12] == ALU_MEM_instr[15:12] ) begin
				out_data_2_fwd = memory_out_data;
				out_data_2_use_fwd = 1;
			end
			if(F_R_instr[11:8] == ALU_MEM_instr[15:12] ) begin
				out_data_3_fwd = memory_out_data;
				out_data_3_use_fwd = 1;
			end
			if(F_R_instr[3:0] == ALU_MEM_instr[15:12] ) begin
				out_data_4_fwd = memory_out_data;
				out_data_4_use_fwd = 1;
			end
		end

		if(ALU_MEM_instr[24] == 0 || ALU_MEM_instr[21] ==1 ) begin //postindexing or //preindexing and write back bit set
				if(F_R_instr[19:16] == ALU_MEM_instr[19:16] ) begin	
					out_data_1_fwd =ALU_MEM_alu_result;
					out_data_1_use_fwd = 1;
				end
				if(F_R_instr[15:12] == ALU_MEM_instr[19:16] ) begin	
					out_data_2_fwd =ALU_MEM_alu_result;
					out_data_2_use_fwd = 1;
				end
				if(F_R_instr[11:8] == ALU_MEM_instr[19:16] ) begin	
					out_data_3_fwd =ALU_MEM_alu_result;
					out_data_3_use_fwd = 1;
				end
				if(F_R_instr[3:0] == ALU_MEM_instr[19:16] ) begin	
					out_data_4_fwd =ALU_MEM_alu_result;
					out_data_4_use_fwd = 1;
				end
		end
	end

	if(ALU_MEM_type == `dataProcessing && ALU_MEM_will_this_be_executed==1 && ALU_MEM_alu_is_writeback ==1) begin
		if(F_R_instr[19:16] == ALU_MEM_instr[15:12]) begin
				out_data_1_fwd = ALU_MEM_alu_result;
				out_data_1_use_fwd = 1;
		end
		if(F_R_instr[15:12] == ALU_MEM_instr[15:12]) begin
				out_data_2_fwd = ALU_MEM_alu_result;
				out_data_2_use_fwd = 1;
		end
		if(F_R_instr[11:8] == ALU_MEM_instr[15:12]) begin
				out_data_3_fwd = ALU_MEM_alu_result;
				out_data_3_use_fwd = 1;
		end
		if(F_R_instr[3:0] == ALU_MEM_instr[15:12]) begin
				out_data_4_fwd = ALU_MEM_alu_result;
				out_data_4_use_fwd = 1;
		end
	end

	if(ALU_MEM_type == `multiply && ALU_MEM_will_this_be_executed==1) begin
		if(F_R_instr[19:16] == ALU_MEM_instr[19:16]) begin
				out_data_1_fwd= ALU_MEM_alu_result;	//remember accumulate?
				out_data_1_use_fwd = 1;
		end
		if(F_R_instr[15:12] == ALU_MEM_instr[19:16]) begin
				out_data_2_fwd= ALU_MEM_alu_result;	//remember accumulate?
				out_data_2_use_fwd = 1;
		end
		if(F_R_instr[11:8] == ALU_MEM_instr[19:16]) begin
				out_data_3_fwd= ALU_MEM_alu_result;	//remember accumulate?
				out_data_3_use_fwd = 1;
		end
		if(F_R_instr[3:0] == ALU_MEM_instr[19:16]) begin
				out_data_4_fwd= ALU_MEM_alu_result;	//remember accumulate?
				out_data_4_use_fwd = 1;
		end
	end


	//From ALU stage
	if(MUL_ALU_type == `dataProcessing && MUL_ALU_will_this_be_executed==1 && alu_is_writeback ==1) begin
		if(F_R_instr[19:16] == MUL_ALU_instr[15:12]) begin
				out_data_1_fwd = alu_result;
				out_data_1_use_fwd = 1;
		end
		if(F_R_instr[15:12] == MUL_ALU_instr[15:12]) begin
				out_data_2_fwd = alu_result;
				out_data_2_use_fwd = 1;
		end
		if(F_R_instr[11:8] == MUL_ALU_instr[15:12]) begin
				out_data_3_fwd = alu_result;
				out_data_3_use_fwd = 1;
		end
		if(F_R_instr[3:0] == MUL_ALU_instr[15:12]) begin
				out_data_4_fwd = alu_result;
				out_data_4_use_fwd = 1;
		end
	end

	if(MUL_ALU_type == `multiply && MUL_ALU_will_this_be_executed==1) begin
		if(F_R_instr[19:16] == MUL_ALU_instr[19:16]) begin
				out_data_1_fwd= alu_result;	//remember accumulate?
				out_data_1_use_fwd = 1;
		end
		if(F_R_instr[15:12] == MUL_ALU_instr[19:16]) begin
				out_data_2_fwd= alu_result;	//remember accumulate?
				out_data_2_use_fwd = 1;
		end
		if(F_R_instr[11:8] == MUL_ALU_instr[19:16]) begin
				out_data_3_fwd= alu_result;	//remember accumulate?
				out_data_3_use_fwd = 1;
		end
		if(F_R_instr[3:0] == MUL_ALU_instr[19:16]) begin
				out_data_4_fwd= alu_result;	//remember accumulate?
				out_data_4_use_fwd = 1;
		end
	end

	//From MUL stage
	//There is problem with forwarding instructions. We can't do forwarding from register stage itself.

	//ALU to ALU:
	if(MUL_ALU_type == `dataProcessing && MUL_ALU_will_this_be_executed==1 && alu_is_writeback ==1) begin
		if(R_MUL_instr[19:16] == MUL_ALU_instr[15:12]) begin
				MUL_ALU_data_1_fwd = alu_result;
				MUL_ALU_data_1_use_fwd = 1;
		end
		if(R_MUL_instr[15:12] == MUL_ALU_instr[15:12]) begin
				MUL_ALU_data_2_fwd = alu_result;
				MUL_ALU_data_2_use_fwd = 1;
		end
		if(R_MUL_instr[11:8] == MUL_ALU_instr[15:12]) begin
				MUL_ALU_data_3_fwd = alu_result;
				MUL_ALU_data_3_use_fwd = 1;
		end
		if(R_MUL_instr[3:0] == MUL_ALU_instr[15:12]) begin
				MUL_ALU_data_4_fwd = alu_result;
				MUL_ALU_data_4_use_fwd = 1;
		end
	end

	if(MUL_ALU_type == `multiply && MUL_ALU_will_this_be_executed==1) begin
		if(R_MUL_instr[19:16] == MUL_ALU_instr[19:16]) begin
				MUL_ALU_data_1_fwd= alu_result;	//remember accumulate?
				MUL_ALU_data_1_use_fwd = 1;
		end
		if(R_MUL_instr[15:12] == MUL_ALU_instr[19:16]) begin
				MUL_ALU_data_2_fwd= alu_result;	//remember accumulate?
				MUL_ALU_data_2_use_fwd = 1;
		end
		if(R_MUL_instr[11:8] == MUL_ALU_instr[19:16]) begin
				MUL_ALU_data_3_fwd= alu_result;	//remember accumulate?
				MUL_ALU_data_3_use_fwd = 1;
		end
		if(R_MUL_instr[3:0] == MUL_ALU_instr[19:16]) begin
				MUL_ALU_data_4_fwd= alu_result;	//remember accumulate?
				MUL_ALU_data_4_use_fwd = 1;
		end
	end

	//
end


//ALU. 
always@(*) begin
	case(MUL_ALU_type)
		`dataProcessing: begin
				alu_operand_1 = MUL_ALU_out_data_1;	//=R[instr[[19:16]]
				use_shifter = 1; 					//alu_operand_2 = shifter_result;
				alu_opcode = MUL_ALU_instr[24:21];
			end

		`multiply: begin
			if(MUL_ALU_instr[21] == 1 ) begin //Multiply accumulate
				alu_operand_1 = MUL_ALU_out_data_2;	//=R[instr[[19:16]]
				alu_operand_2 = MUL_ALU_mult_result;
				use_shifter = 0;
				alu_opcode = `ADD;
			end
			else begin	//No accumulate. Add 0, so that nzcv flags go through.
				alu_operand_1 = 0;
				alu_operand_2 = MUL_ALU_mult_result;
				use_shifter = 0;
				alu_opcode = `ADD;
			end
		end

		`branch: begin	//address calculation
			//flush instructions.
			//want_to_flush = 1;
			alu_operand_1 = current_pc-4;	//because current pc is 3 instructions ahead. As seen from simulator
			alu_operand_2 = (MUL_ALU_instr[23] == 1)? {6'b111111,MUL_ALU_instr[23:0],2'b00}:{6'b000000,MUL_ALU_instr[23:0],2'b00};	//sign extended 24 bit offset.
			use_shifter = 0;
			alu_opcode = `ADD;
		end

		`loadStoreUnsigned: begin
			//address calculation
			alu_operand_1 = MUL_ALU_out_data_1;		//base register.
			use_shifter = 1;	//offset			//alu_operand_2 = shifter_result;
			alu_opcode = (MUL_ALU_instr[23]==1)?`ADD: `SUB;	//depending on up bit
		end

		/*
		Not supported yet: 
		Multiply long
		Need not do anything for
		`undefined
		`branchAndExchange
		*/

		default: begin
				//want_to_flush = 0;
				alu_operand_1 = MUL_ALU_out_data_1;
				use_shifter = 1; //alu_operand_2 = shifter_result;	
				alu_opcode =`ADD;
			end
	endcase
end


//Memory
always@(*) begin
	if(ALU_MEM_will_this_be_executed == 0) begin
		memory_read_enable = 0;
		memory_write_enable = 0;
	end
	else begin
		case(ALU_MEM_type)
			`loadStoreUnsigned: begin
				memory_data_address = (ALU_MEM_instr[24]==1)?ALU_MEM_alu_result:ALU_MEM_out_data_1;	//pre or post indexing
				isByte = ALU_MEM_instr[22];
				if(ALU_MEM_instr[20] == 0) begin	//store
					memory_in_data = ALU_MEM_out_data_2;	//store base register
					memory_write_enable = 1;
				end
				else begin //load
					memory_read_enable = 1;
				end
			end



			default: begin
				memory_write_enable = 0;
				memory_read_enable = 0;
			end
		endcase	
	end
end


//Write back
always@(*) begin
	if(MEM_W_will_this_be_executed == 0) begin
		pc_update = current_pc + 4;//
		pc_write = 1;
		cspr_write = 0;
		write_enable = 0;
		write_enable_2 = 0;
	end

	else begin

		case(MEM_W_type)
			`dataProcessing:begin
				write_address = MEM_W_instr[15:12];
				write_data = MEM_W_alu_result;
				write_enable = (MEM_W_alu_is_writeback == 1)? 1:0;
				write_enable_2 = 0;
				cspr_update = {MEM_W_alu_nzcv,cspr_update[27:0]};
				cspr_write = MEM_W_instr[20];	//set bit
				pc_update = current_pc + 4;
				pc_write = 1;
			end

			`multiply: begin
				write_address = MEM_W_instr[19:16];
				write_data = MEM_W_alu_result;	//remember accumulate?
				write_enable = 1;
				write_enable_2 = 0;
				cspr_update = {MEM_W_alu_nzcv,cspr_update[27:0]};
				cspr_update = MEM_W_instr[20];	//set bit
				pc_update = current_pc + 4;
				pc_write = 1;
			end

			`branch: begin
				pc_update = MEM_W_alu_result;
				pc_write = 1;
				cspr_write = 0;
				if(MEM_W_instr[24]==0)	write_enable = 0;	//i.e, not link
				else begin
					write_address = 4'd14;
					write_enable = 1;
					write_data = current_pc-28;
				end
				write_enable_2 = 0;
			end

			`branchAndExchange: begin
				pc_update = MEM_W_out_data_3;
				pc_write = 1;
				cspr_write = 0;
				write_enable = 0;
				write_enable_2 = 0;
			end

			`loadStoreUnsigned: begin
				if(MEM_W_instr[20]==1) begin 	//Load from memory
					write_data = MEM_W_memory_out_data;
					write_address = MEM_W_instr[15:12];
					write_enable = 1;
				end
				else write_enable = 0;	//store from memory

				if(MEM_W_instr[24] == 0 || MEM_W_instr[21] ==1 ) begin	//postindexing or //preindexing and write back bit set
					write_address_2 = MEM_W_instr[19:16];
					write_data_2 = MEM_W_alu_result;
					write_enable_2 = 1;
				end
				else write_enable_2 = 0; 
				cspr_write = 0;
				pc_update = current_pc + 4;
				pc_write = 1;
			end
			/*
			Not supported yet: 
				Multiply long
			Just to increase pc:
				undefined
			*/
			default: begin
				pc_update = current_pc +4;//
				pc_write = 1;
				cspr_write = 0;
				write_enable = 0;
			end
		endcase

	end
end


//Pipeline update
always @(posedge clk) begin
	fetch_instr = 1; 
	if(number_stalls!=0) number_stalls = number_stalls-1;

	//i.e no stalls
	else begin
		current_pc = pc_update;

		/*******MEM/W*****/
		MEM_W_will_this_be_executed =(ALU_MEM_flush ==1)?0:ALU_MEM_will_this_be_executed;
		MEM_W_type 			 = ALU_MEM_type;
		MEM_W_instr 		 = ALU_MEM_instr;
		MEM_W_out_data_1 	 = ALU_MEM_out_data_1;
		MEM_W_out_data_2 	 = ALU_MEM_out_data_2;
		MEM_W_out_data_3 	 = ALU_MEM_out_data_3;
		MEM_W_out_data_4 	 = ALU_MEM_out_data_4;
		MEM_W_memory_out_data = memory_out_data;
		MEM_W_mult_result 	 = ALU_MEM_mult_result;
		MEM_W_alu_result 	 = ALU_MEM_alu_result;
		MEM_W_alu_nzcv 		 = ALU_MEM_alu_nzcv;
		MEM_W_alu_is_writeback = ALU_MEM_alu_is_writeback;
		MEM_W_flush			 = ALU_MEM_flush;
		/*******MEM/W*****/

		
		/*******ALU/MEM*****/
		ALU_MEM_will_this_be_executed = (MUL_ALU_flush==1)?0:MUL_ALU_will_this_be_executed;
		ALU_MEM_type 		 = MUL_ALU_type;
		ALU_MEM_instr 		 = MUL_ALU_instr;
		ALU_MEM_out_data_1 	 = MUL_ALU_out_data_1;
		ALU_MEM_out_data_2 	 = MUL_ALU_out_data_2;
		ALU_MEM_out_data_3 	 = MUL_ALU_out_data_3;
		ALU_MEM_out_data_4 	 = MUL_ALU_out_data_4;
		ALU_MEM_mult_result  = MUL_ALU_mult_result;
		ALU_MEM_alu_result 	 = alu_result;
		ALU_MEM_alu_nzcv 	 = alu_nzcv;
		ALU_MEM_alu_is_writeback  = alu_is_writeback;
		ALU_MEM_flush		 = MUL_ALU_flush;
		nzcv_forward = alu_nzcv;	//forwarding!
		/*******ALU/MEM*****/

		/*******MUL/ALU*****/
		////condition field checking done in alu stage, right aftern zcvnzcv is calculated . so if decided to be not executing, make type undefined.
		MUL_ALU_will_this_be_executed = (R_MUL_flush == 1)?0:will_this_be_executed;
		MUL_ALU_type 		 =R_MUL_type;
		MUL_ALU_instr 		 =R_MUL_instr;
		MUL_ALU_out_data_1 	 =(MUL_ALU_data_1_use_fwd == 0)?R_MUL_out_data_1: MUL_ALU_data_1_fwd;
		MUL_ALU_out_data_2 	 =(MUL_ALU_data_2_use_fwd == 0)?R_MUL_out_data_2: MUL_ALU_data_2_fwd;
		MUL_ALU_out_data_3 	 =(MUL_ALU_data_3_use_fwd == 0)?R_MUL_out_data_3: MUL_ALU_data_3_fwd;
		MUL_ALU_out_data_4 	 =(MUL_ALU_data_4_use_fwd == 0)?R_MUL_out_data_4: MUL_ALU_data_4_fwd;
		MUL_ALU_mult_result	 = mult_result;
		MUL_ALU_flush		 = R_MUL_flush;
		//MUL_ALU_shifter_result = shifter_result;
		/*******MUL/ALU*****/

		/*******R/MUL*****/
		R_MUL_type 			 =F_R_type;
		R_MUL_instr 		 =F_R_instr;
		R_MUL_out_data_1 	 =(out_data_1_use_fwd == 0)?out_data_1:out_data_1_fwd;
		R_MUL_out_data_2 	 =(out_data_2_use_fwd == 0)?out_data_2:out_data_2_fwd;
		R_MUL_out_data_3 	 =(out_data_3_use_fwd == 0)?out_data_3:out_data_3_fwd;
		R_MUL_out_data_4 	 =(out_data_4_use_fwd == 0)?out_data_4:out_data_4_fwd;
		R_MUL_flush			 =F_R_flush;
		/*******R/MUL*****/

		/*******F/R*****/
		F_R_instr    = instr;
		F_R_type 	 = itype;
		F_R_flush	 =  want_to_flush;
		/*******F/R*****/

		//Flushing: For branch instructions at write back stage, flush all the pipeline filled
		if(MUL_ALU_type==`branch )begin
			want_to_flush=1;
		end
		if(MUL_ALU_type!=`branch && MUL_ALU_type!=`dataProcessing && MUL_ALU_type!=`multiply && MUL_ALU_type!=`loadStoreUnsigned)begin
			want_to_flush = 0;
		end
		if( (MEM_W_type == `branch || MEM_W_type == `branchAndExchange) && (MEM_W_will_this_be_executed ==1)) begin
			want_to_flush = 1;
			F_R_flush = 1;
			R_MUL_flush = 1;
			MUL_ALU_flush = 1;
			ALU_MEM_flush = 1;
		end
		else begin
			want_to_flush = 0;
		end

	end
end

endmodule
