`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: Warren Jayakumar
// 
// Create Date: 01/07/2025 11:35:15 PM
// Design Name: 32 bit ALU
// Module Name: ALU_32bit
// Project Name: RISC-V Single Cycle Processor
// Target Devices: 
// Tool Versions: 
// Description: 32 bit ALU for RISC V processor
// 
// Dependencies: 
// 
// Revision:
// Revision 0.01 - File Created
// Additional Comments:
// 
//////////////////////////////////////////////////////////////////////////////////


module ALU_32bit(
    input [31:0] a,
    input [31:0] b,
    output reg [31:0] result,
    input resetn,
    input [2:0] control
    );
    
    always @ (*) begin
        if (!resetn) begin
            result  <= 32'h00000000;
        end else begin
            case(control)
                3'b000: result <= a + b;
                3'b001: result <= a - b;
                3'b010: result <= a ^ b;
                3'b011: result <= a | b;
                3'b100: result <= a & b;
                3'b101: result <= a << b;
                3'b110: result <= a >> b;
                3'b111: result <= a < b ? 1 : 0;
                default: result <= 32'h00000000;
            endcase
        end
    end
    
endmodule
