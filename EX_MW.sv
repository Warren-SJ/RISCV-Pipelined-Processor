`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 01/28/2025 10:25:49 PM
// Design Name: 
// Module Name: EX_MW
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


module EX_MW(
    input [31:0] alu_result_in,
    output reg [31:0] alu_result_out,
    input [31:0] write_data_in,
    output reg [31:0] write_data_out,
    input [4:0] rd_address_in,
    output reg [4:0] rd_address_out,
    input data_write_en_in,
    output reg data_write_en_out,
    input reg_write_in,
    output reg reg_write_out,
    input [1:0] alu_or_load_or_pc_plus_four_in,
    output reg [1:0] alu_or_load_or_pc_plus_four_out,
    input [31:0] pc_current_in,
    output reg [31:0] pc_current_out,
    input [1:0] data_men_write_command_in,
    output reg [1:0] data_men_write_command_out,
    input [2:0] load_gen_command_in,
    output reg [2:0] load_gen_command_out,
    input clk,
    input resetn
    );
    always @(posedge clk) begin
        if (!resetn) begin
            alu_result_out <= 32'h00000000;
            write_data_out <= 32'h00000000;
            data_write_en_out <= 1'b0;
            reg_write_out <= 1'b0;
            alu_or_load_or_pc_plus_four_out <= 1'b0;
            pc_current_out <= 32'h00000000;
            rd_address_out <= 5'b00000;
            data_men_write_command_out <= 2'b00;
            load_gen_command_out <= 3'b000;
        end else begin
            alu_result_out <= alu_result_in;
            write_data_out <= write_data_in;
            data_write_en_out <= data_write_en_in;
            reg_write_out <= reg_write_in;
            alu_or_load_or_pc_plus_four_out <= alu_or_load_or_pc_plus_four_in;
            pc_current_out <= pc_current_in;
            rd_address_out <= rd_address_in;
            data_men_write_command_out <= data_men_write_command_in;
            load_gen_command_out <= load_gen_command_in;
        end
    end
endmodule
