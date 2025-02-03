`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 01/10/2025 11:12:08 PM
// Design Name: 
// Module Name: Immediate_Generator
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


module Immediate_Generator(
    input [24:0] immediate_region,
    input [4:0] instruction,
    output reg [31:0] immediate
    );
    always @(*)        case(instruction)
            5'b00100: immediate <= {{20{immediate_region[24]}}, immediate_region[24:13]};
            5'b00000: immediate <= {{20{immediate_region[24]}}, immediate_region[24:13]};
            5'b01000: immediate <= {{20{immediate_region[24]}}, immediate_region[24:18], immediate_region[4:0]};
            5'b11000: immediate <= {{20{immediate_region[24]}}, immediate_region[0], immediate_region[23:18], immediate_region[4:1], 1'b0};
            5'b11011: immediate <= {{12{immediate_region[24]}}, immediate_region[12:5], immediate_region[13], immediate_region[23:14], 1'b0};
            5'b11001: immediate <= {{20{immediate_region[24]}}, immediate_region[24:13]};
            5'b00101: immediate <= {immediate_region[24:5], 12'b0};
            5'b01101: immediate <= {immediate_region[24:5], 12'b0};
            default: immediate <= 32'h00000000;
        endcase
endmodule
