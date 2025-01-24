`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 01/08/2025 11:13:22 PM
// Design Name: 
// Module Name: Instruction_Parser
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


module Instruction_Parser(
    input [31:0] instruction,
    output [4:0] rs1,
    output [4:0] rs2,
    output [4:0] rd,
    output [2:0] func3,
    output [6:0] func7,
    output [6:0] opcode
    );
    assign rs1 = instruction[19:15];
    assign rs2 = instruction[24:20];
    assign rd = instruction[11:7];
    assign func3 = instruction[14:12];
    assign func7 = instruction[31:25];
    assign opcode = instruction[6:0];
//    if (opcode == 7'b010111)
//        assign rs1 = 5'b00000;
//    else
//        assign rs1 = instruction[19:15];
endmodule
