`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2019/04/29 21:49:51
// Design Name: 
// Module Name: EXMEM
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


module EXMEM(
    input clock,
    input reset,
    //in and out for wb and mem
    
    input in_regwrite,  //wb
    output out_regwrite,  //wb
    input in_memtoreg,  //wb
    output out_memtoreg,    //wb
    input in_isBranch,
    output out_isBranch,
    input in_memread,
    output out_memread,
    input in_memwrite,
    output out_memwrite,
    
    input[31:0] in_branch_dst,
    output[31:0] out_branch_dst,
    
    input in_zero,
    output out_zero,
    input[31:0] in_aluresult,
    output[31:0] out_aluresult,
    input[4:0] in_writedst,
    output[4:0] out_writedst,
    input[31:0] in_data,
    output[31:0] out_data
    );
    reg regwrite;
    reg memtoreg;
    reg isBranch;
    reg memread;
    reg memwrite;
    
    reg[31:0] reg_branch_dst;
    reg reg_zero;
    reg[31:0] reg_aluresult;
    reg[4:0] reg_writedst;
    reg[31:0] reg_data;
    assign out_branch_dst=reg_branch_dst;
    assign out_zero=reg_zero;
    assign out_aluresult=reg_aluresult;
    assign out_writedst=reg_writedst;
    assign out_data=reg_data;
    assign out_memwrite=memwrite;
    assign out_memread=memread;
    assign out_isBranch=isBranch;
    assign out_memtoreg=memtoreg;
    assign out_regwrite=regwrite;
    always@(negedge clock)
    begin
        if(reset)
        begin
            regwrite=0;
            memtoreg=0;
            isBranch=0;
            memread=0;
            memwrite=0;
            
            reg_branch_dst=0;
            reg_zero=0;
            reg_aluresult=0;
            reg_writedst=0;
            reg_data=0;
        end
        else
        begin
            reg_branch_dst=in_branch_dst;
            reg_zero=in_zero;
            reg_aluresult=in_aluresult;
            reg_writedst=in_writedst;
            reg_data=in_data;
            regwrite=in_regwrite;
            memtoreg=in_memtoreg;
            isBranch=in_isBranch;
            memread=in_memread;
            memwrite=in_memwrite;
        end
    end
endmodule
