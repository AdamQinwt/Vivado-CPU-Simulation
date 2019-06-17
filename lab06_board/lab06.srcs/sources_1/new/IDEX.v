`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2019/04/29 21:49:51
// Design Name: 
// Module Name: IDEX
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


module IDEX(
    input clock,
    input reset,
    //in and out for ex,wb and mem
    
    input in_regwrite,  //wb
    output out_regwrite,  //wb
    input in_memtoreg,  //wb
    output out_memtoreg,    //wb
    
    input in_isBranch,//mem
    output out_isBranch,
    input in_memread,
    output out_memread,
    input in_memwrite,
    output out_memwrite,
    
    input[1:0] in_aluop,//ex
    output[1:0] out_aluop,
    input in_alusrc,
    output out_alusrc,
    input in_regdst,
    output out_regdst,
    
    input[31:0] in_PCp4,
    output[31:0] out_PCp4,
    input[31:0] in_INS,
    output[31:0] out_INS,
    
    input[31:0] in_a,
    input[31:0] in_b,
    output[31:0] out_a,
    output[31:0] out_b,
    input[31:0] in_signext,
    output[31:0] out_signext,
    input[4:0] in_writedst,
    output[4:0] out_writedst
    );
    reg regwrite;
    reg memtoreg;
    reg isBranch;
    reg memread;
    reg memwrite;
    reg regdst;
    reg alusrc;
    reg[1:0] aluop;
    reg[4:0] reg_writedst;
    reg[31:0] INS;
    reg[31:0] PCp4;
    reg[31:0] a;
    reg[31:0] b;
    reg[31:0] sign_ext;
    assign out_regdst=regdst;
    assign out_alusrc=alusrc;
    assign out_aluop=aluop;
    assign out_a=a;
    assign out_b=b;
    assign out_signext=sign_ext;
    assign out_writedst=reg_writedst;
    assign out_memwrite=memwrite;
    assign out_memread=memread;
    assign out_isBranch=isBranch;
    assign out_memtoreg=memtoreg;
    assign out_regwrite=regwrite;
    assign out_PCp4=PCp4;
    assign out_INS=INS;
    always@(negedge clock)
    begin
        if(reset)
        begin
            regwrite=0;
            memtoreg=0;
            isBranch=0;
            memread=0;
            memwrite=0;
            regdst=0;
            alusrc=0;
            aluop=0;
            reg_writedst=0;
            INS=0;
            PCp4=0;
            a=0;
            b=0;
            sign_ext=0;
        end
        else
        begin
            INS=in_INS;
            PCp4=in_PCp4;
            reg_writedst=in_writedst;
            regwrite=in_regwrite;
            memtoreg=in_memtoreg;
            isBranch=in_isBranch;
            memread=in_memread;
            memwrite=in_memwrite;
            sign_ext=in_signext;
            a=in_a;
            b=in_b;
            aluop=in_aluop;
            alusrc=in_alusrc;
            regdst=in_regdst;
        end
    end
endmodule
