`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 01/29/2025 08:49:19 PM
// Design Name: 
// Module Name: MW_WB
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


module MW_WB(
    input [31:0] read_data_in,
    output reg [31:0] read_data_out,
    input [1:0] alu_or_load_or_pc_plus_four_in,
    output reg [1:0] alu_or_load_or_pc_plus_four_out,
    input reg_write_in,
    output reg reg_write_out,
    input [4:0] rd_address_in,
    output reg [4:0] rd_address_out,
    input [31:0] alu_result_in,
    output reg [31:0] alu_result_out,
    input clk,
    input resetn
    );
    always @(posedge clk) begin
        if (!resetn) begin
            read_data_out <= 32'h00000000;
            alu_or_load_or_pc_plus_four_out <= 2'b00;
            reg_write_out <= 1'b0;
            rd_address_out <= 5'b00000;
            alu_result_out <= 32'h00000000;
        end else begin
            read_data_out <= read_data_in;
            alu_or_load_or_pc_plus_four_out <= alu_or_load_or_pc_plus_four_in;
            reg_write_out <= reg_write_in;
            rd_address_out <= rd_address_in;
            alu_result_out <= alu_result_in;
        end
     end
endmodule
