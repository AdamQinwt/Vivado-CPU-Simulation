`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2019/04/17 10:06:41
// Design Name: 
// Module Name: ALU_COMP
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
    input[31:0] a,
    input[31:0] b,
    input[1:0] op,
    input[31:0] INS_in,
    output[31:0] result_out,
    output zero,
    output [4:0] dest_out,
    output[31:0] b_out,
    input [1:0] aluOp
    );
    reg[3:0] CTR;
    reg zero;
    reg [31:0] result;
    reg[5:0] opcode;
    reg [5:0] func;
    
    always @(a or b or op or INS_in)
    begin
        func=INS_in[5:0];
        opcode=INS_in[31:26];
        casex({aluOp,func})
                    8'b00xxxxxx: CTR=4'b0010;
                    8'bx1xxxxxx: CTR=4'b0110;
                    8'b1xxx0000:CTR=4'b0010;
                    8'b1xxx0010:CTR=4'b0110;
                    8'b1xxx0100:CTR=4'b0000;
                    8'b1xxx0101:CTR=4'b0001;
                    8'b1xxx1010:CTR=4'b0111;
                    8'b1xxx1100:CTR=4'b0100;
                    8'b1xxx1110:CTR=4'b0101;
            endcase
            if(opcode==6'b000001)
            begin
                CTR=4'b0010;
            end
            else if(opcode==6'b000011)
            begin
                CTR=4'b0000;
            end
            else if(opcode==6'b000101)
            begin
                CTR=4'b0001;
            end
        if(CTR==4'b0010)    //add
        begin
            result=a+b;
            if(result==0)
                zero=1;
            else
                zero=0;
        end
        else if(CTR==4'b0110)    //sub
        begin
            result=a-b;
            if(result==0)
                zero=1;
            else
                zero=0;
        end
        else if(CTR==4'b0000)    //and
        begin
            result=a&b;
            if(result==0)
                zero=1;
            else
                zero=0;
        end
        else if(CTR==4'b0001)    //or
        begin
            result=a|b;
            if(result==0)
                zero=1;
            else
                zero=0;
        end
        else if(CTR==4'b0111)    //set on less than
        begin
            if(a<b)
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
        else if(CTR==4'b1100)    //nor
        begin
            result=~(a|b);
            if(result==0)
                zero=1;
            else
                zero=0;
        end
        else if(CTR==4'b0100)    //sll
        begin
            result=(a<<b);
            if(result==0)
                zero=1;
            else
                zero=0;
        end
        else if(CTR==4'b0101)    //srl
        begin
            result=(a>>b);
            if(result==0)
                zero=1;
            else
                zero=0;
        end
    end
    assign result_out=result;
    
endmodule
