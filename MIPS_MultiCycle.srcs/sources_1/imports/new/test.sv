`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2021/03/25 08:05:05
// Design Name: 
// Module Name: test
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


//module testbench();
//	logic clk;
//	logic reset;
//	logic [31:0] writedata, adr;
//	logic memwrite;
//	// instantiate device to be tested
//	top dut (clk, reset, writedata, adr, memwrite);
//	// initialize test
//	initial	begin
//		reset <= 1; # 22; reset <= 0;
//	end
//	// generate clock to sequence tests
//	always begin
//		clk <= 1; # 5; clk <= 0; # 5;
//	end
//	// check results
//	always @(negedge clk) begin
//		if (memwrite) begin
//			if (adr===84 & writedata===7) begin
//				$display("Simulation succeeded");
//				$stop;
//			end else if (adr !==80) begin
//				$display("Simulation failed");
//				$stop;
//			end
//		end
//	end
//endmodule 

module test(
    );
    logic           clk;
    logic           reset,L,R;
    logic [15:0]    SW;
    logic [7:0]     AN;
    logic [6:0]     A2G;

    top dut(clk, reset, L, R, SW, AN, A2G);
    initial
        begin
           #0;reset<=1;
           #2;reset<=0;
           #2;L<=1;R<=1;
           #2;SW<=16'h1234;
        end            
        always
            begin
                clk = 1;
                #1;
                clk = 0;
                #1;
            end
endmodule