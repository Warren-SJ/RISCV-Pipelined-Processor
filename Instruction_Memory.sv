`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: Warren Jayakumar
// 
// Create Date: 01/06/2025 10:59:52 PM
// Design Name: Instruction Memory
// Module Name: Instruction_Memory
// Project Name: RISC-V Single Cycle Processor
// Target Devices: 
// Tool Versions: 
// Description: Instruction memory for the processor. Byte addressable. 512 bytes can be stored
// 
// Dependencies: 
// 
// Revision:
// Revision 0.01 - File Created
// Additional Comments:
// 
//////////////////////////////////////////////////////////////////////////////////


module Instruction_Memory(
    input [31:0] adddress,
    output reg [31:0] instruction,
    input clk,
    input resetn
    );
    
    reg [7:0] memory [63:0];

// Uncomment for simulation	 
//  initial begin 
//		  memory[0] <= 8'b00000000;
//		  memory[1] <= 8'b00000000;
//		  memory[2] <= 8'b00000000;
//		  memory[3] <= 8'b00000000;
//		  
//		  // addi x1, x0, 15
//		  memory[4] <= 8'b00000000;
//		  memory[5] <= 8'b11110000;
//		  memory[6] <= 8'b00000000;
//		  memory[7] <= 8'b10010011; 
//	 
//		  // xori x2, x1, 58
//		  memory[8] <= 8'b00000011;
//		  memory[9] <= 8'b10100000;
//		  memory[10] <= 8'b11000001;
//		  memory[11] <= 8'b00010011;
//	 
//		  // lh x3, 12(x1)
//		  memory[12]  <= 8'b00000000;
//		  memory[13]  <= 8'b11000000;
//		  memory[14] <= 8'b10010001;
//		  memory[15] <= 8'b10000011;
//	 
//		  // slt x4 x3 x1
//		  memory[16] <= 8'b00000000;
//		  memory[17] <= 8'b00010001;
//		  memory[18] <= 8'b10100010;
//		  memory[19] <= 8'b00110011;
//	 
//		  // slli x5 x3 1
//		  memory[20] <= 8'b00000000;
//		  memory[21] <= 8'b00010001;
//		  memory[22] <= 8'b10010010;
//		  memory[23] <= 8'b10010011;
//		  
//		  // sw x5, 20(x1)
//		  memory[24] <= 8'b00000000;
//		  memory[25] <= 8'b01010000;
//		  memory[26] <= 8'b10101010;
//		  memory[27] <= 8'b00100011;
//		  
//		  // lui x12 460
//		  memory[28] <= 8'b00000000;
//		  memory[29] <= 8'b00011100;
//		  memory[30] <= 8'b11000110;
//		  memory[31] <= 8'b00110111;
//		  
//		  // auipc x15, 570
//		  memory[32] <= 8'b00000000;
//		  memory[33] <= 8'b00100011;
//		  memory[34] <= 8'b10100111;
//		  memory[35] <= 8'b10010111;
//		  
//		  // jal x10 40
////      memory[28] <= 8'b00000010;
////      memory[29] <= 8'b10000000;
////      memory[30] <= 8'b00000101;
////      memory[31] <= 8'b01101111;
//		  
//		  // jalr x25, 8(x4)
////      memory[28] <= 8'b00000000;
////      memory[29] <= 8'b10000010;
////      memory[30] <= 8'b00001100;
////      memory[31] <= 8'b11100111;
//		  
//		  
//		  // blt x3 x5 20
////      memory[28] <= 8'b00000000;
////      memory[29] <= 8'b01010001;
////      memory[30] <= 8'b11001110;
////      memory[31] <= 8'b01100011;
//
//  end

    
    always_ff @ (posedge clk) begin
        if (!resetn) begin
          memory[0] <= 8'b00000000;
          memory[1] <= 8'b00000000;
          memory[2] <= 8'b00000000;
          memory[3] <= 8'b00000000;
          
          // addi x1, x0, 15
          memory[4] <= 8'b00000000;
          memory[5] <= 8'b11110000;
          memory[6] <= 8'b00000000;
          memory[7] <= 8'b10010011; 
     
          // xori x2, x1, 58
          memory[8] <= 8'b00000011;
          memory[9] <= 8'b10100000;
          memory[10] <= 8'b11000001;
          memory[11] <= 8'b00010011;
     
          // lh x3, 12(x1)
          memory[12]  <= 8'b00000000;
          memory[13]  <= 8'b11000000;
          memory[14] <= 8'b10010001;
          memory[15] <= 8'b10000011;
     
          // slt x4 x3 x1
          memory[16] <= 8'b00000000;
          memory[17] <= 8'b00010001;
          memory[18] <= 8'b10100010;
          memory[19] <= 8'b00110011;
     
          // slli x5 x3 1
          memory[20] <= 8'b00000000;
          memory[21] <= 8'b00010001;
          memory[22] <= 8'b10010010;
          memory[23] <= 8'b10010011;
          
          // sw x5, 20(x1)
          memory[24] <= 8'b00000000;
          memory[25] <= 8'b01010000;
          memory[26] <= 8'b10101010;
          memory[27] <= 8'b00100011;
          
          // lui x12 460
          memory[28] <= 8'b00000000;
          memory[29] <= 8'b00011100;
          memory[30] <= 8'b11000110;
          memory[31] <= 8'b00110111;
          
          // auipc x15, 570
          memory[32] <= 8'b00000000;
          memory[33] <= 8'b00100011;
          memory[34] <= 8'b10100111;
          memory[35] <= 8'b10010111;
          
          // jal x10 40
//        memory[28] <= 8'b00000010;
//        memory[29] <= 8'b10000000;
//        memory[30] <= 8'b00000101;
//        memory[31] <= 8'b01101111;
          
          // jalr x25, 8(x4)
//        memory[28] <= 8'b00000000;
//        memory[29] <= 8'b10000010;
//        memory[30] <= 8'b00001100;
//        memory[31] <= 8'b11100111;
          
          
          // blt x3 x5 20
//        memory[28] <= 8'b00000000;
//        memory[29] <= 8'b01010001;
//        memory[30] <= 8'b11001110;
//        memory[31] <= 8'b01100011;
	
          instruction  <= 32'h00000000;
        end else begin
          instruction[7:0] <= memory[adddress + 3];
          instruction[15:8] <= memory[adddress + 2];
          instruction[23:16] <= memory[adddress + 1];
          instruction[31:24] <= memory[adddress + 0];
        end
    end
endmodule
