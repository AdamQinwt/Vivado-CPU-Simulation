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


module Registers(
    input [25:21] readReg1,
    input [20:16] readReg2,
    input [4:0] writeReg,
    input [31:0] writeData,
    input regWrite,
    input reset,
    output[31:0] out,
    output [31:0] readData1,
    output [31:0] readData2,
    output[4:0] test_out,
    input clock
    );
    reg [31:0] regFile[31:0];
    reg[31:0] readData1;
    reg[31:0] readData2;
    reg[5:0] i;
    assign test_out=regFile[3];
    /*
always @ (readReg1 or readReg2 or writeReg)
	begin
	   readData1=regFile[readReg1];
		readData2=regFile[readReg2];
		if(regWrite==1'b1)
		begin
              regFile[writeReg]=writeData;
		end
	end*/
	assign test_out=regFile[3][3:0];
always @ (negedge clock)
	begin
	   if(reset)
	   begin
	   for(i=0;i<32;i=i+1)
	      regFile[i]=3;
	   end
	   readData1=regFile[readReg1];
		readData2=regFile[readReg2];
		if(regWrite==1'b1)
		begin
              regFile[writeReg]=writeData;
		end
	end
endmodule
