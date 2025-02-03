`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 01/25/2025 11:07:20 PM
// Design Name: 
// Module Name: IF_ID
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


module IF_ID(
    input [31:0] instruction_in,
    input branch_or_not,
    input [31:0] pc_next,
    input [31:0] pc_current,
    input [31:0] branch_address_in,
    output reg [31:0] instruction_out,
    output reg [31:0] pc_next_out,
    output reg [31:0] pc_current_out,
    output reg [31:0] branch_address_out,
    output reg branch_or_not_out,
    input clk,
    input resetn
    );
    always @(posedge clk) begin
        if (!resetn) begin
            instruction_out <= 32'h00000000;
            pc_next_out <= 32'h00000000;
            pc_current_out <= 32'h00000000;
            branch_address_out <= 32'h00000000;
            branch_or_not_out <= 1'b0;
        end else begin
                pc_next_out <= pc_next;
                pc_current_out <= pc_current;
            if (branch_or_not) begin 
                instruction_out <= 32'h00000000;
                branch_address_out <= branch_address_in;
                branch_or_not_out <= 1'b1;
            end else begin
                instruction_out <= instruction_in;
                branch_or_not_out <= 1'b0;
            end
       end
    end
endmodule
