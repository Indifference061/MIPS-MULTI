`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2023/02/27 10:05:51
// Design Name: 
// Module Name: top
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


module top(
    input logic CLK100MHZ,BTNC,
    input logic BTNL,BTNR,
    input logic [15:0] SW,
    output logic [7:0] AN,
    output logic [6:0] A2G
    );
    logic [31:0] aluout,dataadr,readdata,writedata;
    logic Write,IOclock;
    assign IOclock=~CLK100MHZ;
    
    mips mips(CLK100MHZ,BTNC,readdata,dataadr,
             writedata,Write);
    
    dMemoryDecoder dmd(.clk(CLK100MHZ),
                       .writeEN(Write),
                       .addr(dataadr),
                       .writeData(writedata),
                       .readData(readdata),
                       .IOclock(IOclock),
                       .reset(BTNC),
                       .btnL(BTNL),
                       .btnR(BTNR),
                       .switch(SW),
                       .an(AN),
                       .a2g(A2G));
endmodule

//module top(
//    input  logic       clk,reset,
//    output logic[31:0] writedata,dataadr,
//    output logic       memwrite
//    );
//    logic[31:0] readdata;
    
    
//    // instantiate processor and memories
    
//    mips mips(clk,reset,readdata,dataadr,
//              writedata,memwrite);
//    mem mem(clk,memwrite,dataadr, writedata, readdata);
//endmodule