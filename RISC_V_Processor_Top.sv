`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: Warren Jayakumar
// 
// Create Date: 01/06/2025 11:05:14 PM
// Design Name: RISC V Processor Top
// Module Name: RISC_V_Processor_Top
// Project Name: RISC-V Single Cycle Processor
// Target Devices: 
// Tool Versions: 
// Description: The top module of the RISC-V processor
// 
// Dependencies: 
// 
// Revision:
// Revision 0.01 - File Created
// Additional Comments:
// 
//////////////////////////////////////////////////////////////////////////////////


module RISC_V_Processor_Top(
    input clk,
    input resetn,
    input select_output,
	output reg [6:0] hex0,
	output reg [6:0] hex1,
	output reg [6:0] hex2,
	output reg [6:0] hex3,
	output reg [6:0] hex4,
	output reg [6:0] hex5,
	output reg [6:0] hex6,
	output reg [6:0] hex7
    );
    
    // Output
    wire [31:0] output_value;
    
    
    // PC wires
    wire [31:0] pc_next;
    wire [31:0] pc_current;
    wire [31:0] pc_plus_four;
    
    // Instruction Memory wires
    wire [31:0] instruction;
    
    // Register file wires
    wire [31:0] rs1_data;
    wire [31:0] rs2_data;
    wire [31:0] rd_data;
    wire [4:0] rs1_address;
    wire [4:0] rs2_address;
    wire [4:0] rd_address;
    wire reg_write;
    
    //ALU wires
    wire [2:0] alu_operation;
	wire [31:0] alu_result;
    
    //Immediate wires
    wire [31:0]rs2_data_or_immediate;
    wire limit_immediate;
    wire [31:0] limited_immediate;
    wire [31:0] immediate;
    wire reg_or_immediate;
    
    //Data memory wires
    wire [31:0] data_mem_read_data_corrected;
    wire [31:0] data_mem_read_data;
    wire data_mem_write;
    wire branch_possibility;
    
    //Branching wires
    wire branch_or_not;
    
    //Jump wires
    wire [1:0] alu_or_load_or_pc_plus_four_control;
    
    //Upper immediate wires
    wire [31:0] rs1_data_or_pc_or_zero;
    wire [1:0] rs1_data_or_pc_or_zero_control;
    
    
    //Instruction Fetch - Instruction Decode Pipeline Register
    wire [31:0] fetched_instruction;
    wire [31:0] branch_address;
    wire [31:0] pc_plus_four_out;
    wire [31:0] branch_address_out;
    wire [31:0] pc_current_out;
    wire branch_or_not_out;
    
    //Instruction Decode - Instruction Execute Pipeline Register
    wire [31:0] alu_input1;
    wire [31:0] alu_input2;
    wire [31:0] data_to_store;
    wire [2:0] alu_operation_out;
    wire reg_write_out;
    wire [4:0] rd_address_out;
    wire data_mem_write_out;
    wire [1:0] alu_or_load_or_pc_plus_four_control_out;
    wire [31:0] pc_plus_four_out_ex;
    wire [31:0] pc_current_out_ex;
    wire [1:0] data_men_write_command_out;
    wire [2:0] load_gen_command_out;
    
    //Instruction Execute - Memory Write Pipeline Register
    wire [31:0] alu_result_out;
    wire [31:0] data_to_store_out;
    wire data_mem_write_out_ex;
    wire [1:0] alu_or_load_or_pc_plus_four_control_ex;
    wire reg_write_out_ex;
    wire [31:0] pc_plus_four_out_mw;
    wire [4:0] rd_address_out_mw;
    wire [1:0] data_men_write_command_out_mw;
    wire [2:0] load_gen_command_out_mw;
    
    //Memory Write - Register Writeback Pipeline Register
    wire [31:0] data_mem_read_data_corrected_out;
    wire [1:0] alu_or_load_or_pc_plus_four_control_mw;
    wire reg_write_out_mw;
    wire [4:0] rd_address_out_wb;
    wire [31:0] alu_result_out_wb;
    
    PC PC(
        .inst_addr_in(pc_next),
        .inst_addr_out(pc_current),
        .clk(clk),
        .resetn(resetn)
    );
    
    Instruction_Memory Instruction_Memory(
        .adddress(pc_current),
        .instruction(fetched_instruction),
        .clk(clk),
        .resetn(resetn)
    );
    
    Adder_32bit PC_Adder(
        .a(pc_current),
        .b(32'h00000004),
        .result(pc_plus_four),
        .resetn(resetn)
    );
    
    Register_File Register_File(
        .rs1(rs1_address),
        .rs2(rs2_address),
        .rd(rd_address_out_wb),
        .rs1_data(rs1_data),
        .rs2_data(rs2_data),
        .write_data(rd_data),
        .write_enable(reg_write_out_mw),
        .clk(clk),
        .resetn(resetn)
    );
    
    ALU_32bit ALU_32bit(
        .a(alu_input1),
        .b(alu_input2),
        .result(alu_result),
        .resetn(resetn),
        .control(alu_operation_out)
    );
    
    Control_Unit Control_Unit(
        .instruction(instruction),
        .reg_write(reg_write),
        .rs1(rs1_address),
        .rs2(rs2_address),
        .rd(rd_address),
        .alu_op(alu_operation),
        .immediate(immediate),
        .limit_immediate(limit_immediate),
        .resetn(resetn),
        .data_mem_write(data_mem_write),
        .reg_or_immediate(reg_or_immediate),
        .rs1_data_or_pc_or_zero(rs1_data_or_pc_or_zero_control),
        .alu_or_load_or_pc_plus_four(alu_or_load_or_pc_plus_four_control),
        .branch_possibility(branch_possibility)
    );
    
    Two_One_Mux Reg_or_Immediate(
        .sel(reg_or_immediate),
        .a(limited_immediate),
        .b(rs2_data),
        .out(rs2_data_or_immediate)
    );

    Immediate_Limiter Immediate_Limiter(
         .immediate_input(immediate),
         .limit(limit_immediate),
         .immediate_output(limited_immediate)
    );
    
    Data_Memory Data_Memory(
        .write_address(alu_result_out),
        .write_en(data_mem_write_out_ex),
        .write_data(data_to_store_out),
        .write_command(data_men_write_command_out_mw),
        .read_data(data_mem_read_data),
        .clk(clk),
        .resetn(resetn),
        .read_address(alu_result_out)
    );
    
    Load_Generator Load_Generator(
        .data_input(data_mem_read_data),
        .control(load_gen_command_out_mw),
        .data_output(data_mem_read_data_corrected),
        .resetn(resetn)
    );
    
    Three_One_Mux Alu_or_Load_or_Pc_plus_four(
        .sel(alu_or_load_or_pc_plus_four_control_mw),
        .a(alu_result_out_wb),
        .b(data_mem_read_data_corrected_out),
        .c(pc_plus_four_out_ex),
        .out(rd_data)
    );
    
    Three_One_Mux Rs1_data_or_Pc_or_Zero(
        .sel(rs1_data_or_pc_or_zero_control),
        .a(rs1_data),
        .b(pc_current_out_ex),
        .c(32'h00000000),
        .out(rs1_data_or_pc_or_zero)
    );
    
    Branch_Comparator Branch_Comparator(
        .rs1(rs1_data),
        .rs2(rs2_data),
        .branch_or_not(branch_or_not),
        .command({instruction[2],instruction[14:12]}),
        .branch_possibility(branch_possibility)
    );
    
    Adder_32bit Branch_Adder(
        .a(pc_current_out_ex),
        .b(immediate),
        .result(branch_address),
        .resetn(resetn)
    );
    
    Two_One_Mux PC_plus_four_or_Branch(
        .sel(branch_or_not_out),
        .a(pc_plus_four),
        .b(branch_address_out),
        .out(pc_next)
    );
    
    IF_ID IF_ID_Register(
        .instruction_in(fetched_instruction),
        .branch_or_not(branch_or_not),
        .branch_or_not_out(branch_or_not_out),
        .instruction_out(instruction),
        .pc_next(pc_plus_four),
        .pc_next_out(pc_plus_four_out),
        .pc_current(pc_current),
        .pc_current_out(pc_current_out),
        .branch_address_in(branch_address),
        .branch_address_out(branch_address_out),
        .clk(clk),
        .resetn(resetn)
    );
    
    ID_EX ID_EX_Register(
        .alu_input1_in(rs1_data_or_pc_or_zero),
        .alu_input1_out(alu_input1),
        .alu_input2_in(rs2_data_or_immediate),
        .alu_input2_out(alu_input2),
        .data_memory_store_in(rs2_data),
        .data_memory_store_out(data_to_store),
        .alu_control_in(alu_operation),
        .alu_control_out(alu_operation_out),
        .reg_write_in(reg_write),
        .reg_write_out(reg_write_out),
        .rd_address_in(rd_address),
        .rd_address_out(rd_address_out),
        .data_mem_write_in(data_mem_write),
        .data_mem_write_out(data_mem_write_out),
        .alu_or_load_or_pc_plus_four_in(alu_or_load_or_pc_plus_four_control),
        .alu_or_load_or_pc_plus_four_out(alu_or_load_or_pc_plus_four_control_out),
        .pc_plus_four(pc_plus_four_out),
        .pc_plus_four_out(pc_plus_four_out_ex),
        .pc_current(pc_current_out),
        .pc_current_out(pc_current_out_ex),
        .data_men_write_command_in(instruction[13:12]),
        .data_men_write_command_out(data_men_write_command_out),
        .load_gen_command_in(instruction[14:12]),
        .load_gen_command_out(load_gen_command_out),
        .clk(clk),
        .resetn(resetn)
    );
    
    EX_MW EX_MW_Register(
        .alu_result_in(alu_result),
        .alu_result_out(alu_result_out),
        .write_data_in(data_to_store),
        .write_data_out(data_to_store_out),
        .data_write_en_in(data_mem_write_out),
        .data_write_en_out(data_mem_write_out_ex),
        .reg_write_in(reg_write_out),
        .reg_write_out(reg_write_out_ex),
        .alu_or_load_or_pc_plus_four_in(alu_or_load_or_pc_plus_four_control_out),
        .alu_or_load_or_pc_plus_four_out(alu_or_load_or_pc_plus_four_control_ex),
        .pc_plus_four_in(pc_plus_four_out_ex),
        .pc_plus_four_out(pc_plus_four_out_mw),
        .rd_address_in(rd_address_out),
        .rd_address_out(rd_address_out_mw),
        .data_men_write_command_in(data_men_write_command_out),
        .data_men_write_command_out(data_men_write_command_out_mw),
        .load_gen_command_in(load_gen_command_out),
        .load_gen_command_out(load_gen_command_out_mw),
        .clk(clk),
        .resetn(resetn)
    );
    
    MW_WB MW_WB_Register(
        .read_data_in(data_mem_read_data_corrected),
        .read_data_out(data_mem_read_data_corrected_out),
        .alu_or_load_or_pc_plus_four_in(alu_or_load_or_pc_plus_four_control_ex),
        .alu_or_load_or_pc_plus_four_out(alu_or_load_or_pc_plus_four_control_mw),
        .reg_write_in(reg_write_out_ex),
        .reg_write_out(reg_write_out_mw),
        .rd_address_in(rd_address_out_mw),
        .rd_address_out(rd_address_out_wb),
        .alu_result_in(alu_result_out),
        .alu_result_out(alu_result_out_wb),
        .clk(clk),
        .resetn(resetn)
    );
    
   
	hex_decoder u_hex0 (
		.bin(output_value[3:0]),   
		.seg(hex0)
	);
	
	hex_decoder u_hex1 (
		.bin(output_value[7:4]),   
		.seg(hex1)
	);
	
	hex_decoder u_hex2 (
		.bin(output_value[11:8]),  
		.seg(hex2)
	);
	
	hex_decoder u_hex3 (
		.bin(output_value[15:12]), 
		.seg(hex3)
	);
	
	hex_decoder u_hex4 (
		.bin(output_value[19:16]), 
		.seg(hex4)
	);
	hex_decoder u_hex5 (
		.bin(output_value[23:20]), 
		.seg(hex5)
	);
	
	hex_decoder u_hex6 (
		.bin(output_value[27:24]), 
		.seg(hex6)
	);
	
	hex_decoder u_hex7 (
		.bin(output_value[31:28]), 
		.seg(hex7)
	);
	
	Two_One_Mux Output_Select(
        .sel(select_output),
        .a(alu_result),
        .b(rd_data),
        .out(output_value)
    );
    
endmodule
