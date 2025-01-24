`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 01/12/2025 10:35:30 PM
// Design Name: 
// Module Name: Load_Generator
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


module Load_Generator(
    input [31:0] data_input,
    input [2:0] control,
    output reg [31:0] data_output,
    input resetn
    );
    always @ (*) begin
        if (!resetn) begin
            data_output  <= 32'h00000000;
        end else begin
             case(control)
                3'b000: data_output <= {{24{data_input[7]}}, data_input[7:0]};
                3'b001: data_output <= {{16{data_input[15]}}, data_input[15:0]};
                3'b010: data_output <=  data_input[31:0];
                3'b100: data_output <= {24'b0, data_input[7:0]};
                3'b101: data_output <= {16'b0, data_input[15:0]};
            endcase 
        end
     end
endmodule
