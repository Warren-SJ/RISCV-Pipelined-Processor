`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 01/26/2025 10:55:31 PM
// Design Name: 
// Module Name: ID_EX
// Project Name: 
// Target Devices: 
// Tool Versions: 
// Description: 
// 
// Dependencies: 
// 
// Revision:
// Revision 0.01 - File Created
// Additional Comments:
// 
//////////////////////////////////////////////////////////////////////////////////


module ID_EX(
    input [31:0] alu_input1_in,
    output reg [31:0] alu_input1_out,
    input [31:0] alu_input2_in,
    output reg [31:0] alu_input2_out,
    input [31:0] data_memory_store_in,
    output reg [31:0] data_memory_store_out,
    input [2:0] alu_control_in,
    output reg [2:0] alu_control_out,
    input reg_write_in,
    output reg reg_write_out,
    input [4:0] rd_address_in,
    output reg [4:0] rd_address_out,
    input data_mem_write_in,
    output reg data_mem_write_out,
    input [1:0] alu_or_load_or_pc_plus_four_in,
    output reg [1:0] alu_or_load_or_pc_plus_four_out,
    input [31:0] pc_plus_four,
    output reg [31:0] pc_plus_four_out,
    input [31:0] pc_current,
    output reg [31:0] pc_current_out,
    input clk,
    input resetn
    );
    always @(posedge clk) begin
        if (!resetn) begin
            alu_input1_out <= 32'h00000000;
            alu_input2_out <= 32'h00000000;
            data_memory_store_out <= 32'h00000000;
            alu_control_out <= 3'b000;
            reg_write_out <= 1'b0;
            rd_address_out <= 5'b00000;
            data_mem_write_out <= 1'b0;
            alu_or_load_or_pc_plus_four_out <= 2'b00;
            pc_plus_four_out <= 32'h00000000;
            pc_current_out <= 32'h00000000;
        end else begin
            alu_input1_out <= alu_input1_in;
            alu_input2_out <= alu_input2_in;
            data_memory_store_out <= data_memory_store_in;
            alu_control_out <= alu_control_in;
            reg_write_out <= reg_write_in;
            rd_address_out <= rd_address_in;
            data_mem_write_out <= data_mem_write_in;
            alu_or_load_or_pc_plus_four_out <= alu_or_load_or_pc_plus_four_in;
            pc_plus_four_out <= pc_plus_four;
            pc_current_out <= pc_current;
        end
    end
endmodule
