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


module memory_tb(

    );
    wire[31:0] readData;
    reg [31:0] address;
    reg[31:0] writeData;
    reg clock;
    reg memWrite;
    reg memRead;
    memory m(
        .address(address),
        .memRead(memRead),
        .memWrite(memWrite),
        .writeData(writeData),
        .readData(readData),
        .clock(clock)
    );
parameter PERIOD=10;
always #(PERIOD*2) clock=!clock;
initial begin
    clock=1'b0;
    memWrite=1'b0;
    memRead=1'b0;
    #50;
    memWrite=1'b1;
    address=32'h00000001;
    writeData=32'hffff00ff;
    #200;
    address=32'h00000002;
    writeData=32'h11111111;
    #200;
    memWrite=1'b0;
    address=32'h00000001;
    writeData=32'h00000000;
    #50;
    memRead=1'b1;
    address=32'h00000001;
end
endmodule
