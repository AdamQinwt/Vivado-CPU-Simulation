`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2019/04/10 10:44:36
// Design Name: 
// Module Name: ALU
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


module ALU(
    input [31:0] input1,
    input [31:0] input2,
    input [3:0] ctr,
    output zero,
    output [31:0] aluRes
    );
    reg zero;
    reg [31:0] result;
    always @(input1 or input2 or ctr)
    begin
        if(ctr==4'b0010)    //add
        begin
            result=input1+input2;
            if(result==0)
                zero=1;
            else
                zero=0;
        end
        else if(ctr==4'b0110)    //sub
        begin
            result=input1-input2;
            if(result==0)
                zero=1;
            else
                zero=0;
        end
        else if(ctr==4'b0000)    //and
        begin
            result=input1&input2;
            if(result==0)
                zero=1;
            else
                zero=0;
        end
        else if(ctr==4'b0001)    //or
        begin
            result=input1|input2;
            if(result==0)
                zero=1;
            else
                zero=0;
        end
        else if(ctr==4'b0111)    //set on less than
        begin
            if(input1<input2)
                begin
                    result=1;
                //    zero=0;
                end
            else
                begin
                    result=0;
               //     zero=1;
                end
        end
        else if(ctr==4'b1100)    //nor
        begin
            result=~(input1|input2);
            if(result==0)
                zero=1;
            else
                zero=0;
        end
        else if(ctr==4'b0100)    //sll
        begin
            result=(input1<<input2);
            if(result==0)
                zero=1;
            else
                zero=0;
        end
        else if(ctr==4'b0101)    //srl
        begin
            result=(input1>>input2);
            if(result==0)
                zero=1;
            else
                zero=0;
        end
    end
    assign aluRes=result;
endmodule
