`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2019/04/17 07:59:09
// Design Name: 
// Module Name: Registers_tb
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


module Registers_tb(

    );
    wire[31:0] readData1;
    wire[31:0] readData2;
    reg [25:21] readReg1;
    reg [20:16] readReg2;
    reg [4:0] writeReg;
    reg[31:0] writeData;
    reg clock;
    reg regWrite;
    Registers r(
        .readReg1(readReg1),
        .readReg2(readReg2),
        .writeReg(writeReg),
        .writeData(writeData),
        .regWrite(regWrite),
        .readData1(readData1),
        .readData2(readData2),
        .clock(clock)
    );
parameter PERIOD=10;
always #(PERIOD*2) clock=!clock;
initial begin
    clock=1'b0;
    regWrite=1'b0;
    #50;
    regWrite=1'b1;
    writeReg=5'b10101;
    writeData=32'hffff00ff;
    #200;
    writeReg=5'b01010;
    writeData=32'hf00f00ff;
    #200;
    regWrite=1'b0;
    writeReg=5'b10101;
    writeData=32'h0x00000000;
    #50;
    readReg1=5'b10101;
    readReg2=5'b01010;
end
endmodule
