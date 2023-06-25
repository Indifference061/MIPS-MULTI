`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2023/03/02 16:18:35
// Design Name: 
// Module Name: dMemoryDecoder
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


module dMemoryDecoder(
    input  logic        clk, writeEN,
    input  logic [31:0] addr, writeData,
    output logic [31:0] readData,

    input  logic        IOclock,
    input  logic        reset,
    input  logic        btnL, btnR,
    input  logic [15:0] switch,
    output logic [7:0]  an,
    output logic [6:0]  a2g
    );
    
    logic pRead, pWrite, mWrite;
    logic [11:0] led,led1;
    logic [31:0] preadData, mreadData;

    assign pRead = (addr[7] == 1'b1) ? 1 : 0;
    assign pWrite = (addr[7] == 1'b1) ? writeEN : 0;
    assign mWrite = writeEN & (addr[7] == 1'b0);

    IO io(IOclock, reset, pRead, pWrite, addr[3:2], writeData, preadData,
          btnL, btnR, switch, led);
    mem mem(clk, mWrite, addr, writeData, mreadData);
    assign readData = (addr[7] == 1'b1) ? preadData : mreadData;    
    mux7Seg sg(IOclock, reset, {switch, 4'b0000, led}, an, a2g);
endmodule
