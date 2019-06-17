`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2019/04/29 21:43:05
// Design Name: 
// Module Name: WB
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


module WB(
    input clock,
    input reset,
    
    input memToReg,
    input in_regwrite,
    output out_regwrite,
    input[31:0] regdata,
    input[31:0] memdata,
    output[31:0] writedata,
    input[4:0] in_regdst,
    output[4:0] out_regdst
    );
    reg regwrite;
    reg[31:0] reg_writedata;
    reg[4:0] regdst;
    assign out_regdst=regdst;
    assign out_regwrite=regwrite;
    assign writedata=reg_writedata;
    
    always@(posedge clock)
    begin
        if(reset)
        begin
            regwrite=0;
            reg_writedata=0;
            regdst=0;
        end
        else
        begin
            regdst=in_regdst;
            reg_writedata=memToReg?memdata:regdata;
            regwrite=in_regwrite;
        end
    end
endmodule
