`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2019/04/29 21:49:51
// Design Name: 
// Module Name: MEMWB
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


module MEMWB(
    input clock,
    input reset,
    
    input in_regwrite,  //wb
    output out_regwrite,  //wb
    input in_memtoreg,  //wb
    output out_memtoreg,    //wb
    
    input[4:0] in_reg,
    output[4:0] out_reg,
    
    input[31:0] in_memdata,
    input[31:0] in_regdata,
    output[31:0] out_memdata,
    output[31:0] out_regdata
    );
    reg regwrite;
    reg memtoreg;
    reg[4:0] reg_reg;
    reg[31:0] regdata;
    reg[31:0] memdata;
    assign out_memtoreg=memtoreg;
    assign out_regwrite=regwrite;
    assign out_reg=reg_reg;
    assign out_regdata=regdata;
    assign out_memdata=memdata;
    always@(negedge clock)
    begin
        if(reset)
        begin
            regwrite=0;
            memtoreg=0;
            reg_reg=0;
            regdata=0;
            memdata=0;
        end
        else
        begin
            regwrite=in_regwrite;
            memtoreg=in_memtoreg;
            reg_reg=in_reg;
            regdata=in_regdata;
            memdata=in_memdata;
        end
    end
endmodule
