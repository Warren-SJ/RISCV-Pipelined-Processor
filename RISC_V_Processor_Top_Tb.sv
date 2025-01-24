`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 01/08/2025 11:54:54 PM
// Design Name: 
// Module Name: RISC_V_Processor_Top_Tb
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


`timescale 1ns / 1ps

module RISC_V_Processor_Top_Tb;

    reg clk;
    reg resetn;

    RISC_V_Processor_Top RISC_V_Processor_Top (
        .clk(clk),
        .resetn(resetn)
    );

    always #5 clk = ~clk;

    initial begin
        clk = 0;
        resetn = 0;
        
        $dumpfile("RISC_V_Processor_Top.vcd");
        $dumpvars(0, RISC_V_Processor_Top_Tb);
        
        #10;
        resetn = 1;
        #150;

        $finish;
    end
    initial begin
        $monitor("Time: %0t | Reset: %b | Clock: %b", $time, resetn, clk);
    end
endmodule

