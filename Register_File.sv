`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 01/06/2025 11:46:20 PM
// Design Name: 
// Module Name: Register_File
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


module Register_File(
    input [4:0] rs1,
    input [4:0] rs2,
    input [4:0] rd,
    output reg [31:0] rs1_data,
    output reg [31:0] rs2_data,
    input [31:0] write_data,
    input write_enable,
    input clk,
    input resetn
    );
    
    reg [31:0] registers [31:0];
    
    initial begin
        registers[0] = 32'h00000000;
    end
    
    always_comb begin
        rs1_data = registers[rs1];
        rs2_data = registers[rs2];
    end
    
    always_ff @(posedge clk) begin
        if (!resetn) begin
            for (integer i = 0; i < 32; i = i + 1)
                registers[i] <= 32'h00000000;
        end else if (write_enable && rd != 5'b00000) begin
            registers[rd] <= write_data;
        end
    end
endmodule

