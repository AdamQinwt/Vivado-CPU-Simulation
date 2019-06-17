`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2019/04/17 07:53:10
// Design Name: 
// Module Name: Registers
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


module MEM(
    input [31:0] address,
    input [31:0] writeData,
    input memWrite,
    input memRead,
    output [31:0] out_readData,
    input clock
    );
    reg [31:0] memFile[0:63];
    reg[31:0] readData;
always @ (posedge memRead)
	begin
              readData=memFile[address];
	end
always@(negedge clock)
	begin
	if(memWrite==1'b1)
		begin
              memFile[address]=writeData;
       end
	else if(memRead==1'b1)
		begin
              readData=memFile[address];
		end
	end
endmodule
