`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: Warren Jayakumar
// 
// Create Date: 01/06/2025 11:23:33 PM
// Design Name: 32 bit adder
// Module Name: Adder_32bit
// Project Name: RISC-V Single Cycle Processor
// Target Devices: 
// Tool Versions: 
// Description: Adds 2 32 bit numbers and returns the sum
// 
// Dependencies: 
// 
// Revision:
// Revision 0.01 - File Created
// Additional Comments:
// 
//////////////////////////////////////////////////////////////////////////////////


module Adder_32bit(
    input [31:0] a,
    input [31:0] b,
    output reg [31:0] result,
    input resetn
    );
    always @ (*) begin
        if (!resetn) begin
            result  <= 32'h00000000;
        end else begin
            result <= a + b;
        end
    end
endmodule
