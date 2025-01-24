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
    
    PC PC(
        .inst_addr_in(pc_next),
        .inst_addr_out(pc_current),
        .clk(clk),
        .resetn(resetn)
    );
    
    Instruction_Memory Instruction_Memory(
        .adddress(pc_current),
        .instruction(instruction),
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
        .rd(rd_address),
        .rs1_data(rs1_data),
        .rs2_data(rs2_data),
        .write_data(rd_data),
        .write_enable(reg_write),
        .clk(clk),
        .resetn(resetn)
    );
    
    ALU_32bit ALU_32bit(
        .a(rs1_data_or_pc_or_zero),
        .b(rs2_data_or_immediate),
        .result(alu_result),
        .resetn(resetn),
        .control(alu_operation)
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
        .write_address(alu_result),
        .write_en(data_mem_write),
        .write_data(rs2_data),
        .write_command(instruction[13:12]),
        .read_data(data_mem_read_data),
        .clk(clk),
        .resetn(resetn),
        .read_address(alu_result)
    );
    
    Load_Generator Load_Generator(
        .data_input(data_mem_read_data),
        .control(instruction[14:12]),
        .data_output(data_mem_read_data_corrected),
        .resetn(resetn)
    );
    
    Three_One_Mux Alu_or_Load_or_Pc_plus_four(
        .sel(alu_or_load_or_pc_plus_four_control),
        .a(alu_result),
        .b(data_mem_read_data_corrected),
        .c(pc_plus_four),
        .out(rd_data)
    );
    
    Three_One_Mux Rs1_data_or_Pc_or_Zero(
        .sel(rs1_data_or_pc_or_zero_control),
        .a(rs1_data),
        .b(pc_current),
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
    
    Two_One_Mux PC_plus_four_or_Branch(
        .sel(branch_or_not),
        .a(pc_plus_four),
        .b(alu_result),
        .out(pc_next)
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
		.bin(alu_result[15:12]), 
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
