`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2023/03/27 11:39:52
// Design Name: 
// Module Name: floprdouble
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


module floprdouble #(parameter WIDTH = 8)(
    input  logic clk, reset,
    input  logic [WIDTH-1 : 0] d1, d2,
    output logic [WIDTH-1 : 0] a, b
);
    always_ff @(posedge clk or posedge reset) begin
        if (reset) begin
            a <= 0;
            b <= 0; 
        end
        else begin
            a <= d1;
            b <= d2;
        end 
    end
endmodule
