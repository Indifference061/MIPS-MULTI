`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2023/02/27 10:12:59
// Design Name: 
// Module Name: mips
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


module mips(input logic clk, reset, 
			input logic [31:0] readdata,
			output logic [31:0] adr, writedata,
			output logic memwrite);
	logic zero, pcen, irwrite, regwrite, alusrca, iord, memtoreg, regdst;
	logic [1:0] alusrcb, pcsrc;
	logic [2:0] alucontrol;
	logic [5:0] op, funct;
	controller c(clk, reset, op, funct, zero, iord, memwrite, irwrite, regdst, memtoreg,
			regwrite, alusrca, alusrcb, alucontrol, pcsrc, pcen);
	datapath dp(clk, reset, pcen, iord, irwrite, regdst, memtoreg, regwrite, alusrca,
			alusrcb, alucontrol, pcsrc, readdata, op, funct, zero, adr, writedata);
endmodule
