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
    input [31:0] calculated_branch_address,
    output reg [31:0] instruction_out,
    output reg branch_or_not_out,
    output reg [31:0] calculated_branch_address_out,
    input clk,
    input resetn
    );
    always @(posedge clk) begin
        if (!resetn) begin
            instruction_out <= 32'h00000000;
            branch_or_not_out <= 1'b0;
            calculated_branch_address_out <= 32'h00000000;
        end else begin
            instruction_out <= instruction_in;
            branch_or_not_out <= branch_or_not;
            calculated_branch_address_out <= calculated_branch_address;
        end
    end
endmodule
