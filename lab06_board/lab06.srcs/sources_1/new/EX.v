`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2019/04/29 20:56:22
// Design Name: 
// Module Name: EX
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


module EX(
    input clock,
    input reset,

    input in_regwrite,  //wb
    output out_regwrite,  //wb
    input in_memtoreg,  //wb
    output out_memtoreg,    //wb
    
    input in_memread,//mem
    input in_memwrite,//mem
    input in_branch,//mem
    output out_memread,//mem
    output out_memwrite,//mem
    output out_branch,//mem
    
    input alusrc,
    input[1:0] aluop,
    input regdst,
    
    input[31:0] A,
    input[31:0] b,
    input[31:0] sign_ext,
    output[4:0] write_dst,
    output[31:0]alu_result,
    output zero,
    output[31:0] data2,
    
    input[31:0] in_PCP4,
    output[31:0] out_PCdst,
    input[31:0] in_INS,
    output[31:0] out_INS
    );
    reg[3:0] aluctr;
    reg[31:0] reg_result;
    reg[31:0] reg_data2;
    reg[31:0] B;
    reg[4:0] reg_writedst;
    reg[31:0] PCdst;
    reg reg_zero;
    assign out_PCdst=PCdst;
    assign zero=reg_zero;
    assign alu_result=reg_result;
    assign data2=reg_data2;
    assign out_regwrite=in_regwrite;
    assign out_memtoreg=in_memtoreg;
    assign out_memread=in_memread;
    assign out_memwrite=in_memwrite;
    assign out_branch=in_branch;
    assign out_INS=in_INS;
    assign write_dst=reg_writedst;
    
    always@(posedge clock)
    begin
        if(reset)
        begin
            aluctr=0;
            reg_result=0;
            reg_data2=0;
            B=0;
            reg_writedst=0;
            PCdst=0;
            reg_zero=0;
        end
        else
        begin
            reg_data2=b;
            B=alusrc?sign_ext:b;
            reg_writedst=regdst?in_INS[15:11]:in_INS[20:16];
            PCdst=in_PCP4+(sign_ext<<2);
            //the code from func and aluop to aluctr
            casex({aluop,in_INS[5:0]})
                8'b00xxxxxx: aluctr=4'b0010;
                8'bx1xxxxxx: aluctr=4'b0110;
                8'b1xxx0000: aluctr=4'b0010;
                8'b1xxx0010: aluctr=4'b0110;
                8'b1xxx0100: aluctr=4'b0000;
                8'b1xxx0101: aluctr=4'b0001;
                8'b1xxx1010: aluctr=4'b0111;
            endcase
            //the code to execute alu according to aluctr
            if(aluctr==4'b0010) //add
            begin
                reg_result=A+B;
            end
            else if(aluctr==4'b0110)    //sub
            begin
                reg_result=A-B;
                if(reg_result==0)
                begin
                    reg_zero=1;
                end
            end
            else if(aluctr==4'b0000)    //and
            begin
                reg_result=A&B;
                if(reg_result==0)
                begin
                    reg_zero=1;
                end
            end
            else if(aluctr==4'b0001)    //or
            begin
                reg_result=A|B;
                if(reg_result==0)
                begin
                    reg_zero=1;
                end
            end
            else if(aluctr==4'b0111)    //slt
            begin
                reg_result=A<B?1:0;
                if(reg_result==0)
                begin
                    reg_zero=1;
                end
            end
            else if(aluctr==4'b1100)    //nor
            begin
                reg_result=~(A|B);
                if(reg_result==0)
                begin
                    reg_zero=1;
                end
            end
        end
    end
endmodule
