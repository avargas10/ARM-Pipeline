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




logic[31:0] current_pc;
logic[31:0] pc;
logic[31:0] instr;
logic fetch_instr;
logic[3:0] itype;
instr_Mem instrCache(
                    
						.PC(current_pc),
						.read_enable(fetch_instr),
						.clk(clk),
							
						.instr(instr)		
							);

instr_decode Decoder(
                    .ir(instr),
                    .iType(itype)			
                        );


logic[31:0] instr_f_reg; 
logic[3:0] type_f_reg;		
logic drive_f_reg;


logic[31:0] out_1;
logic[31:0] out_2;
logic[31:0] out_3;
logic[31:0] out_4;
logic[31:0] operand_2;
logic[31:0] cspr;


logic[3:0] read_address; 


logic[3:0] write_address;
logic[31:0] write_data;
logic we1;
logic[3:0] write_address_2;
logic[31:0] write_data_2;
logic we2;
logic[31:0] pc_update;
logic pc_write;
logic cspr_write;
logic[31:0] cspr_update;




registerBank regs(	
                   
                        .in_address1(instr_f_reg[19:16]),
                        .in_address2(instr_f_reg[15:12]),
                        .in_address3(instr_f_reg[11:8]),
                        .in_address4(instr_f_reg[3:0]),
                        .write_address(write_address),
                        .write_address2(write_address_2),							
                        .write_data(write_data),
                        .write_data2(write_data_2),
                        .write_enable(we1),
                        .write_enable2(we2),
                        .pc_update(pc_update), 
                        .pc_write(pc_write), 
                        .cspr_write(cspr_write), 
                        .cspr_update(cspr_update),
                        .clk(clk), 
                        
                   
                        .out_data1(out_1),
                        .out_data2(out_2),
                        .out_data3(out_3),
                        .out_data4(out_4),
                   
				        .pc(pc), 
                        .cspr(cspr)			
                        );

logic[3:0] type_reg_mul;			
logic[31:0] instr_reg_mul;			
logic[31:0] reg_mul_out1;	
logic[31:0] reg_mul_out2;	
logic[31:0] reg_mul_out3;	
logic[31:0] reg_mul_out4;	
logic drive_reg_mul;


logic[31:0] mulRes;
logic[3:0] mult_nzcv;


multiplier mult(
							.Rs(reg_mul_out3), 
							.Rm(reg_mul_out4),
							
							.result(mulRes)

							);

logic[3:0] type_mul_alu;		
logic[31:0] instr_mul_alu;		
logic[31:0] mul_alu_out1;	
logic[31:0] mul_alu_out2;	
logic[31:0] mul_alu_out3;	
logic[31:0] mul_alu_out4;	
logic [31:0] mulRes_mul_alu;	
logic MUL_ALU_will_this_be_executed;	
logic MUL_ALU_c_update; 	
logic MUL_ALU_c_write;	
logic drive_mul_alu;


logic[31:0] aluRes;
logic[3:0] alu_nzcv;
logic isWB_alu;
logic will_this_be_executed;

logic c_to_alu;
logic[31:0] shifter_result;

logic[3:0] next_nzcv;	

logic useShift;
logic[31:0] alu_op1;
logic[31:0] alu_op2;
logic[3:0] alu_opcode;


shift Shifter(		
							.instr_bit_25(instr_mul_alu[25]),
							.imm_value(instr_mul_alu[11:0]), 
							.Rs(mul_alu_out3), 
							.Rm(mul_alu_out4), 
							.cin(next_nzcv[1]),
							.direct_data(alu_op2),
							.use_shifter(useShift),

							
							.operand2(shifter_result), 
							.c_to_alu(c_to_alu)
							
							);

ALU alu(
							.opcode(alu_opcode), 
							.op1(alu_op1), 
							.op2(shifter_result), 
							.nzcv_old(next_nzcv), 
							.cFlag(c_to_alu), 					
							.res(aluRes), 
							.nzcv(alu_nzcv), 
							.isWriteback(isWB_alu)
							);

evaluator instrCheck(
					.nzcv(alu_nzcv),	
					.codeCond(instr_reg_mul[31:28]),
					.isExecuted(will_this_be_executed)						
							);

logic isExecutedAlu_Mem;	
logic[3:0]  type_alu_Mem;			
logic[31:0] instr_alu_Mem;	
logic[31:0] alu_Mem_out1;	
logic[31:0] alu_Mem_out2;	
logic[31:0] alu_Mem_out3;	
logic[31:0] alu_Mem_out4;	
logic [31:0] mulRes_alu_Mem;	
logic [31:0] aluRes_alu_Mem;	
logic [3:0] aluNCZV_alu_Mem;		
logic is_aluWB_alu_Mem;	
logic drive_alu_Mem;


logic[31:0] memOut;
logic[31:0] memory_data_address;
logic[31:0] memory_in_data;
logic mem_we;
logic mem_re;
logic isByte;

data_Mem DataCache(
							.data_address(memory_data_address),
							.in_data(memory_in_data),
							.read_enable(mem_re),
							.write_enable(mem_we),
							.isByte(isByte),
							.clk(clk),							
							.out_data(memOut)
							);

logic isExecutedMem_WB; 
logic[3:0]  type_Mem_WB;
logic[31:0] instr_Mem_WB;
logic[31:0] Mem_WB_out1;
logic[31:0] Mem_WB_out2;
logic[31:0] Mem_WB_out3;
logic[31:0] Mem_WB_out4;		
logic[31:0] memOut_Mem_WB;
logic [31:0] mulRes_Mem_WB;	
logic [31:0] aluRes_Mem_WB;
logic [3:0] aluNCZV_Mem_WB;		
logic is_aluWB_Mem_WB;		
logic drive_Mem_WB;



logic driven;
logic number_stalls;

initial begin
	
	current_pc  = 0;
	pc_update = 0;
	type_f_reg = `undefined;
	type_reg_mul = `undefined;
	type_mul_alu = `undefined;
	type_alu_Mem = `undefined;
	type_Mem_WB = `undefined;
	cspr_update = 0;
	next_nzcv = 0;
	driven = 0;
	number_stalls = 0;
end

/*
//Fetch
always@(posedge clk) begin
	//fetch instruction.
	fetch_instr = 1; 
end*/

logic[31:0] nextData_1;
logic isNext1;
logic[31:0] nextData_2;
logic isNext2;
logic[31:0] nextData_3;
logic isNext3;
logic[31:0] nextData_4;
logic isNext4;

logic[31:0] nextData1_mul_alu;
logic isNext1_mul_alu;
logic[31:0] nextData2_mul_alu;
logic isNext2_mul_alu;
logic[31:0] nextData3_mul_alu;
logic isNext3_mul_alu;
logic[31:0] nextData4_mul_alu;
logic isNext4_mul_alu;


always@(*) begin
	isNext1 =0;
 	isNext2 =0;
	isNext3 =0;
	isNext4 =0;
	isNext1_mul_alu =0;
 	isNext2_mul_alu =0;
	isNext3_mul_alu =0;
	isNext4_mul_alu =0;

	if(we1 == 1) begin
		if(instr_f_reg[19:16] == write_address) begin
			nextData_1 = write_data;
			isNext1 = 1;
		end
		if(instr_f_reg[15:12] == write_address) begin
			nextData_2 = write_data;
			isNext2 = 1;
		end
		if(instr_f_reg[11:8] == write_address) begin
			nextData_3 = write_data;
			isNext3 = 1;
		end
		if(instr_f_reg[3:0] == write_address) begin
			nextData_4 = write_data;
			isNext4 = 1;
		end
	end

	if(we2 == 1) begin
		if(instr_f_reg[19:16] == write_address_2) begin
			nextData_1 = write_data_2;
			isNext1 = 1;
		end
		if(instr_f_reg[15:12] == write_address_2) begin
			nextData_2 = write_data_2;
			isNext2 = 1;
		end
		if(instr_f_reg[11:8] == write_address_2) begin
			nextData_3 = write_data_2;
			isNext3 = 1;
		end
		if(instr_f_reg[3:0] == write_address_2) begin
			nextData_4 = write_data_2;
			isNext4 = 1;
		end
	end

	if(type_alu_Mem == `loadStoreUnsigned && isExecutedAlu_Mem == 1) begin
		
		if(instr_alu_Mem[20]==1) begin 	//Load from memory
			if(instr_f_reg[19:16] == instr_alu_Mem[15:12] ) begin
				nextData_1 = memOut;
				isNext1 = 1;
			end
			if(instr_f_reg[15:12] == instr_alu_Mem[15:12] ) begin
				nextData_2 = memOut;
				isNext2 = 1;
			end
			if(instr_f_reg[11:8] == instr_alu_Mem[15:12] ) begin
				nextData_3 = memOut;
				isNext3 = 1;
			end
			if(instr_f_reg[3:0] == instr_alu_Mem[15:12] ) begin
				nextData_4 = memOut;
				isNext4 = 1;
			end
		end

		if(instr_alu_Mem[24] == 0 || instr_alu_Mem[21] ==1 ) begin //postindexing or //preindexing and write back bit set
				if(instr_f_reg[19:16] == instr_alu_Mem[19:16] ) begin	
					nextData_1 =aluRes_alu_Mem;
					isNext1 = 1;
				end
				if(instr_f_reg[15:12] == instr_alu_Mem[19:16] ) begin	
					nextData_2 =aluRes_alu_Mem;
					isNext2 = 1;
				end
				if(instr_f_reg[11:8] == instr_alu_Mem[19:16] ) begin	
					nextData_3 =aluRes_alu_Mem;
					isNext3 = 1;
				end
				if(instr_f_reg[3:0] == instr_alu_Mem[19:16] ) begin	
					nextData_4 =aluRes_alu_Mem;
					isNext4 = 1;
				end
		end
	end

	if(type_alu_Mem == `dataProcessing && isExecutedAlu_Mem==1 && is_aluWB_alu_Mem ==1) begin
		if(instr_f_reg[19:16] == instr_alu_Mem[15:12]) begin
				nextData_1 = aluRes_alu_Mem;
				isNext1 = 1;
		end
		if(instr_f_reg[15:12] == instr_alu_Mem[15:12]) begin
				nextData_2 = aluRes_alu_Mem;
				isNext2 = 1;
		end
		if(instr_f_reg[11:8] == instr_alu_Mem[15:12]) begin
				nextData_3 = aluRes_alu_Mem;
				isNext3 = 1;
		end
		if(instr_f_reg[3:0] == instr_alu_Mem[15:12]) begin
				nextData_4 = aluRes_alu_Mem;
				isNext4 = 1;
		end
	end

	if(type_alu_Mem == `multiply && isExecutedAlu_Mem==1) begin
		if(instr_f_reg[19:16] == instr_alu_Mem[19:16]) begin
				nextData_1= aluRes_alu_Mem;	//remember accumulate?
				isNext1 = 1;
		end
		if(instr_f_reg[15:12] == instr_alu_Mem[19:16]) begin
				nextData_2= aluRes_alu_Mem;	//remember accumulate?
				isNext2 = 1;
		end
		if(instr_f_reg[11:8] == instr_alu_Mem[19:16]) begin
				nextData_3= aluRes_alu_Mem;	//remember accumulate?
				isNext3 = 1;
		end
		if(instr_f_reg[3:0] == instr_alu_Mem[19:16]) begin
				nextData_4= aluRes_alu_Mem;	//remember accumulate?
				isNext4 = 1;
		end
	end


	//From ALU stage
	if(type_mul_alu == `dataProcessing && MUL_ALU_will_this_be_executed==1 && isWB_alu ==1) begin
		if(instr_f_reg[19:16] == instr_mul_alu[15:12]) begin
				nextData_1 = aluRes;
				isNext1 = 1;
		end
		if(instr_f_reg[15:12] == instr_mul_alu[15:12]) begin
				nextData_2 = aluRes;
				isNext2 = 1;
		end
		if(instr_f_reg[11:8] == instr_mul_alu[15:12]) begin
				nextData_3 = aluRes;
				isNext3 = 1;
		end
		if(instr_f_reg[3:0] == instr_mul_alu[15:12]) begin
				nextData_4 = aluRes;
				isNext4 = 1;
		end
	end

	if(type_mul_alu == `multiply && MUL_ALU_will_this_be_executed==1) begin
		if(instr_f_reg[19:16] == instr_mul_alu[19:16]) begin
				nextData_1= aluRes;	//remember accumulate?
				isNext1 = 1;
		end
		if(instr_f_reg[15:12] == instr_mul_alu[19:16]) begin
				nextData_2= aluRes;	//remember accumulate?
				isNext2 = 1;
		end
		if(instr_f_reg[11:8] == instr_mul_alu[19:16]) begin
				nextData_3= aluRes;	//remember accumulate?
				isNext3 = 1;
		end
		if(instr_f_reg[3:0] == instr_mul_alu[19:16]) begin
				nextData_4= aluRes;	//remember accumulate?
				isNext4 = 1;
		end
	end

	//From MUL stage
	//There is problem with forwarding instructions. We can't do forwarding from register stage itself.

	//ALU to ALU:
	if(type_mul_alu == `dataProcessing && MUL_ALU_will_this_be_executed==1 && isWB_alu ==1) begin
		if(instr_reg_mul[19:16] == instr_mul_alu[15:12]) begin
				nextData1_mul_alu = aluRes;
				isNext1_mul_alu = 1;
		end
		if(instr_reg_mul[15:12] == instr_mul_alu[15:12]) begin
				nextData2_mul_alu = aluRes;
				isNext2_mul_alu = 1;
		end
		if(instr_reg_mul[11:8] == instr_mul_alu[15:12]) begin
				nextData3_mul_alu = aluRes;
				isNext3_mul_alu = 1;
		end
		if(instr_reg_mul[3:0] == instr_mul_alu[15:12]) begin
				nextData4_mul_alu = aluRes;
				isNext4_mul_alu = 1;
		end
	end

	if(type_mul_alu == `multiply && MUL_ALU_will_this_be_executed==1) begin
		if(instr_reg_mul[19:16] == instr_mul_alu[19:16]) begin
				nextData1_mul_alu= aluRes;	//remember accumulate?
				isNext1_mul_alu = 1;
		end
		if(instr_reg_mul[15:12] == instr_mul_alu[19:16]) begin
				nextData2_mul_alu= aluRes;	//remember accumulate?
				isNext2_mul_alu = 1;
		end
		if(instr_reg_mul[11:8] == instr_mul_alu[19:16]) begin
				nextData3_mul_alu= aluRes;	//remember accumulate?
				isNext3_mul_alu = 1;
		end
		if(instr_reg_mul[3:0] == instr_mul_alu[19:16]) begin
				nextData4_mul_alu= aluRes;	//remember accumulate?
				isNext4_mul_alu = 1;
		end
	end

	//
end


//ALU. 
always@(*) begin
	case(type_mul_alu)
		`dataProcessing: begin
				alu_op1 = mul_alu_out1;	//=R[instr[[19:16]]
				useShift = 1; 					//alu_op2 = shifter_result;
				alu_opcode = instr_mul_alu[24:21];
			end

		`multiply: begin
			if(instr_mul_alu[21] == 1 ) begin //Multiply accumulate
				alu_op1 = mul_alu_out2;	//=R[instr[[19:16]]
				alu_op2 = mulRes_mul_alu;
				useShift = 0;
				alu_opcode = `ADD;
			end
			else begin	//No accumulate. Add 0, so that nzcv flags go through.
				alu_op1 = 0;
				alu_op2 = mulRes_mul_alu;
				useShift = 0;
				alu_opcode = `ADD;
			end
		end

		`branch: begin	//address calculation
			//flush instructions.
			//driven = 1;
			alu_op1 = current_pc-4;	//because current pc is 3 instructions ahead. As seen from simulator
			alu_op2 = (instr_mul_alu[23] == 1)? {6'b111111,instr_mul_alu[23:0],2'b00}:{6'b000000,instr_mul_alu[23:0],2'b00};	//sign extended 24 bit offset.
			useShift = 0;
			alu_opcode = `ADD;
		end

		`loadStoreUnsigned: begin
			//address calculation
			alu_op1 = mul_alu_out1;		//base register.
			useShift = 1;	//offset			//alu_op2 = shifter_result;
			alu_opcode = (instr_mul_alu[23]==1)?`ADD: `SUB;	//depending on up bit
		end


		default: begin
				//driven = 0;
				alu_op1 = mul_alu_out1;
				useShift = 1; //alu_op2 = shifter_result;	
				alu_opcode =`ADD;
			end
	endcase
end



always@(*) begin
	if(isExecutedAlu_Mem == 0) begin
		mem_re = 0;
		mem_we = 0;
	end
	else begin
		case(type_alu_Mem)
			`loadStoreUnsigned: begin
				memory_data_address = (instr_alu_Mem[24]==1)?aluRes_alu_Mem:alu_Mem_out1;	//pre or post indexing
				isByte = instr_alu_Mem[22];
				if(instr_alu_Mem[20] == 0) begin	//store
					memory_in_data = alu_Mem_out2;	//store base register
					mem_we = 1;
				end
				else begin //load
					mem_re = 1;
				end
			end



			default: begin
				mem_we = 0;
				mem_re = 0;
			end
		endcase	
	end
end


//Write back
always@(*) begin
	if(isExecutedMem_WB == 0) begin
		pc_update = current_pc + 4;//
		pc_write = 1;
		cspr_write = 0;
		we1 = 0;
		we2 = 0;
	end

	else begin

		case(type_Mem_WB)
			`dataProcessing:begin
				write_address = instr_Mem_WB[15:12];
				write_data = aluRes_Mem_WB;
				we1 = (is_aluWB_Mem_WB == 1)? 1:0;
				we2 = 0;
				cspr_update = {aluNCZV_Mem_WB,cspr_update[27:0]};
				cspr_write = instr_Mem_WB[20];	//set bit
				pc_update = current_pc + 4;
				pc_write = 1;
			end

			`multiply: begin
				write_address = instr_Mem_WB[19:16];
				write_data = aluRes_Mem_WB;	//remember accumulate?
				we1 = 1;
				we2 = 0;
				cspr_update = {aluNCZV_Mem_WB,cspr_update[27:0]};
				cspr_update = instr_Mem_WB[20];	//set bit
				pc_update = current_pc + 4;
				pc_write = 1;
			end

			`branch: begin
				pc_update = aluRes_Mem_WB;
				pc_write = 1;
				cspr_write = 0;
				if(instr_Mem_WB[24]==0)	we1 = 0;	//i.e, not link
				else begin
					write_address = 4'd14;
					we1 = 1;
					write_data = current_pc-28;
				end
				we2 = 0;
			end

			`branchAndExchange: begin
				pc_update = Mem_WB_out3;
				pc_write = 1;
				cspr_write = 0;
				we1 = 0;
				we2 = 0;
			end

			`loadStoreUnsigned: begin
				if(instr_Mem_WB[20]==1) begin 	//Load from memory
					write_data = memOut_Mem_WB;
					write_address = instr_Mem_WB[15:12];
					we1 = 1;
				end
				else we1 = 0;	//store from memory

				if(instr_Mem_WB[24] == 0 || instr_Mem_WB[21] ==1 ) begin	//postindexing or //preindexing and write back bit set
					write_address_2 = instr_Mem_WB[19:16];
					write_data_2 = aluRes_Mem_WB;
					we2 = 1;
				end
				else we2 = 0; 
				cspr_write = 0;
				pc_update = current_pc + 4;
				pc_write = 1;
			end
		
			default: begin
				pc_update = current_pc +4;//
				pc_write = 1;
				cspr_write = 0;
				we1 = 0;
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
		isExecutedMem_WB =(drive_alu_Mem ==1)?0:isExecutedAlu_Mem;
		type_Mem_WB 	 = type_alu_Mem;
		instr_Mem_WB 	 = instr_alu_Mem;
		Mem_WB_out1 	 = alu_Mem_out1;
		Mem_WB_out2 	 = alu_Mem_out2;
		Mem_WB_out3 	 = alu_Mem_out3;
		Mem_WB_out4 	 = alu_Mem_out4;
		memOut_Mem_WB    = memOut;
		mulRes_Mem_WB 	 = mulRes_alu_Mem;
		aluRes_Mem_WB 	 = aluRes_alu_Mem;
		aluNCZV_Mem_WB 	 = aluNCZV_alu_Mem;
		is_aluWB_Mem_WB = is_aluWB_alu_Mem;   
		drive_Mem_WB	 = drive_alu_Mem;
		/*******MEM/W*****/

		
		/*******ALU/MEM*****/
		isExecutedAlu_Mem = (drive_mul_alu==1)?0:MUL_ALU_will_this_be_executed;
		type_alu_Mem 	  = type_mul_alu;
		instr_alu_Mem 	  = instr_mul_alu;
		alu_Mem_out1 	  = mul_alu_out1;
		alu_Mem_out2 	  = mul_alu_out2;
		alu_Mem_out3 	  = mul_alu_out3;
		alu_Mem_out4 	  = mul_alu_out4;
		mulRes_alu_Mem    = mulRes_mul_alu;
		aluRes_alu_Mem 	  = aluRes;
		aluNCZV_alu_Mem   = alu_nzcv;
		is_aluWB_alu_Mem  = isWB_alu;
		drive_alu_Mem	  = drive_mul_alu;
		next_nzcv = alu_nzcv;	//forwarding!
		/*******ALU/MEM*****/

		/*******MUL/ALU*****/
		////condition field checking done in alu stage, right aftern zcvnzcv is calculated . so if decided to be not executing, make type undefined.
		MUL_ALU_will_this_be_executed = (drive_reg_mul == 1)?0:will_this_be_executed;
		type_mul_alu 		 =type_reg_mul;
		instr_mul_alu 		 =instr_reg_mul;
		mul_alu_out1 	     =(isNext1_mul_alu == 0)?reg_mul_out1: nextData1_mul_alu;
		mul_alu_out2 	     =(isNext2_mul_alu == 0)?reg_mul_out2: nextData2_mul_alu;
		mul_alu_out3 	     =(isNext3_mul_alu == 0)?reg_mul_out3: nextData3_mul_alu;
		mul_alu_out4 	     =(isNext4_mul_alu == 0)?reg_mul_out4: nextData4_mul_alu;
		mulRes_mul_alu	     = mulRes;
		drive_mul_alu		 = drive_reg_mul;
		//MUL_ALU_shifter_result = shifter_result;
		/*******MUL/ALU*****/

		/*******R/MUL*****/
		type_reg_mul 		 =type_f_reg;
		instr_reg_mul 		 =instr_f_reg;
		reg_mul_out1 	 	 =(isNext1 == 0)?out_1:nextData_1;
		reg_mul_out2 	 	 =(isNext2 == 0)?out_2:nextData_2;
		reg_mul_out3 	 	 =(isNext3 == 0)?out_3:nextData_3;
		reg_mul_out4 	 	 =(isNext4 == 0)?out_4:nextData_4;
		drive_reg_mul		 =drive_f_reg;
		/*******R/MUL*****/

		/*******F/R*****/
		instr_f_reg    = instr;
		type_f_reg 	 = itype;
		drive_f_reg	 =  driven;
		/*******F/R*****/

		//Flushing: For branch instructions at write back stage, flush all the pipeline filled
		if(type_mul_alu==`branch )begin
			driven=1;
		end
		if(type_mul_alu!=`branch && type_mul_alu!=`dataProcessing && type_mul_alu!=`multiply && type_mul_alu!=`loadStoreUnsigned)begin
			driven = 0;
		end
		if( (type_Mem_WB == `branch || type_Mem_WB == `branchAndExchange) && (isExecutedMem_WB ==1)) begin
			driven = 1;
			drive_f_reg = 1;
			drive_reg_mul = 1;
			drive_mul_alu = 1;
			drive_alu_Mem = 1;
		end
		else begin
			driven = 0;
		end

	end
end

endmodule
