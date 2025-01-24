`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 01/07/2025 11:55:15 PM
// Design Name: 
// Module Name: Two_One_Mux
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


module Two_One_Mux(
    input sel,
    input [31:0] a,
    input [31:0] b,
    output reg [31:0] out
    );
    
    always_comb
        out <= sel ? b : a;
endmodule
