`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: Warren Jayakumar
// 
// Create Date: 01/06/2025 10:49:32 PM
// Design Name: Program Counter
// Module Name: PC
// Project Name: RISC-V Single Cycle Processor
// Target Devices: 
// Tool Versions: 
// Description: Stores the adress of the next instruction
// 
// Dependencies: 
// 
// Revision:
// Revision 0.01 - File Created
// Additional Comments:
// 
//////////////////////////////////////////////////////////////////////////////////


module PC(
    input [31:0] inst_addr_in,
    output reg [31:0] inst_addr_out,
    input clk,
    input resetn
    );
    always_ff @ (posedge clk) begin
        if (!resetn) begin
            inst_addr_out  <= 32'h00000000;
        end else begin
            inst_addr_out <= inst_addr_in;
        end
    end
endmodule
