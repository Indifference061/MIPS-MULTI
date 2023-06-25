`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2023/02/27 10:19:01
// Design Name: 
// Module Name: maindec
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



module maindec(
                input logic clk, reset,
			   input logic [5:0] op,
               output logic memtoreg, memwrite, 
			   output logic [1:0] pcsrc, 
			   output logic pcwrite,
			   output logic regdst, regwrite,
			   output logic iord,irwrite,
			   output logic branch,
			   output logic alusrca,
			   output logic [1:0] alusrcb,
               output logic [2:0] aluop
    );
    logic[15:0] controls;
    logic [3:0] state,nextstate;
    localparam FETCH = 4'b0000;
    localparam DECODE =4'b0001;
    localparam MEMADR =4'b0010;
    localparam MEMRD = 4'b0011;
    localparam MEMWB = 4'b0100;
    localparam MEMWR = 4'b0101;
    localparam RTYPEEX =4'b0110;
    localparam RTYPEWB =4'b0111;
    localparam BEQEX =4'b1000;
    localparam ADDIEX =4'b1001;
    localparam ADDIWB =4'b1010;
    localparam JEX =4'b1011;
    localparam ANDIEX=4'b1100;
    localparam ANDIWB=4'b1101;
    
    localparam LW = 6'b100011;
    localparam SW = 6'b101011;
    localparam RTYPE=6'b000000;
    localparam BEQ =6'b000100;
    localparam ADDI=6'b001000;
    localparam ANDI=6'b001100;
    localparam J =  6'b000010;
    
    always_ff @(posedge clk or posedge reset)
        if(reset) state<=FETCH;
        else      state<=nextstate;
        
    always_comb
        case(state)
            FETCH: nextstate = DECODE;
            DECODE: case(op)
                LW: nextstate=MEMADR;
                SW: nextstate=MEMADR;
                RTYPE: nextstate=RTYPEEX;
                BEQ: nextstate=BEQEX;
                ADDI: nextstate=ADDIEX;
                ANDI:nextstate=ANDIEX;
                J: nextstate=JEX;
                default:nextstate=4'bxxxx;
            endcase
            MEMADR:case(op)
                LW: nextstate=MEMRD;
                SW:nextstate=MEMWR;
                default:nextstate=4'bxxxx;
            endcase
            MEMRD:nextstate=MEMWB;
            MEMWB:nextstate=FETCH;
            MEMWR:nextstate=FETCH;
            RTYPEEX:nextstate=RTYPEWB;
            RTYPEWB:nextstate=FETCH;
            BEQEX:nextstate=FETCH;
            ADDIEX:nextstate=ADDIWB;
            ADDIWB:nextstate=FETCH;
            JEX:nextstate=FETCH;
            ANDIEX:nextstate=ANDIWB;
            ANDIWB:nextstate=FETCH;
            default:nextstate=4'bxxxx;
       endcase
       assign {pcwrite,memwrite,irwrite,regwrite,alusrca,
               branch,iord,memtoreg,regdst,alusrcb,pcsrc,aluop}=controls;
       always_comb
            case(state)
                FETCH:  controls=16'b1010000_0_0_01_00_000;    
                DECODE: controls=16'b0000000_0_0_11_00_000;
                MEMADR: controls=16'b0000100_0_0_10_00_000;    
                MEMRD:  controls=16'b0000001_0_0_00_00_000;
                MEMWB:  controls=16'b0001000_1_0_00_00_000;
                MEMWR:  controls=16'b0100001_0_0_00_00_000;    
                RTYPEEX:controls=16'b0000100_0_0_00_00_010;
                RTYPEWB:controls=16'b0001000_0_1_00_00_000;    
                BEQEX:  controls=16'b0000110_0_0_00_01_001;
                ADDIEX: controls=16'b0000100_0_0_10_00_000;    
                ADDIWB: controls=16'b0001000_0_0_00_00_000;
                JEX:    controls=16'b1000000_0_0_00_10_000;    
                ANDIEX: controls=16'b0000100_0_0_10_00_100;
                ANDIWB: controls=16'b0001000_0_0_00_00_000;    
                default:controls=16'bxxxxxxx_x_x_xx_xx_xxx;
           endcase
endmodule

