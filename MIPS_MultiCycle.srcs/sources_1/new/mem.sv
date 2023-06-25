`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2023/03/27 08:40:50
// Design Name: 
// Module Name: mem
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


module mem(
    input logic clk,we,    
    input logic [31:0]a,
    input logic [31:0]wd,
    output logic [31:0] rd
    );
    logic [31:0]RAM[63:0];
    
    initial begin
        $readmemh("memfileIO.dat",RAM);
        end
    assign rd=RAM[a[31:2]];
    always_ff @(posedge clk) 
        if(we) RAM[a[31:2]]<=wd;
endmodule
//module mem( input logic clk, reset, memwrite, 
//	        input logic [31:0] adr,
//			input logic [31:0] writedata, 
//			output logic [31:0] readdata);

//	logic [31:0] RAM[63:0];
//	initial begin
//		$readmemh("memfile.dat", RAM);
//	end
//	assign readdata = RAM[adr[31:2]]; 
//	always @(posedge clk)
//		if (memwrite)
//			RAM[adr[31:2]] <= writedata;
//endmodule 
