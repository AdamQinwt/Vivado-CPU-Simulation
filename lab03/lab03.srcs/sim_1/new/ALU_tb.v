`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2019/04/10 10:29:41
// Design Name: 
// Module Name: ALUCtr_tb
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


module ALU_tb(

    );
    reg[31:0] input1;
    reg[31:0] input2;
    reg[3:0] ctr;
    wire[31:0] result;
    wire zero;
    ALU u(
        .zero(zero),
        .aluRes(result),
        .ctr(ctr),
        .input1(input1),
        .input2(input2)
    );
     initial begin
        input1=32'h00000002;
        input2=32'h00000003;
        ctr=4'b0010;
        #50;
        ctr=4'b0110;
        #50;
        ctr=4'b0000;
        #50;
        ctr=4'b0001;
        #50;
        ctr=4'b0111;
        #50;
        ctr=4'b1100;
        #50;
        input1=32'h00ab1231;
        input2=32'h00455503;
        ctr=4'b0010;
        #50;
        ctr=4'b0110;
        #50;
        ctr=4'b0000;
        #50;
        ctr=4'b0001;
        #50;
        ctr=4'b0111;
        #50;
        ctr=4'b1100;
        #50;
        input1=32'h00455503;
        input2=32'h00455503;
        ctr=4'b0010;
        #50;
        ctr=4'b0110;
        #50;
        ctr=4'b0000;
        #50;
        ctr=4'b0001;
        #50;
        ctr=4'b0111;
        #50;
        ctr=4'b1100;
        input1=32'hffffffff;
        input2=32'hffffffff;
        ctr=4'b0010;
        #25;
        ctr=4'b0110;
        #25;
        ctr=4'b0000;
        #25;
        ctr=4'b0001;
        #25;
        ctr=4'b0111;
        #25;
        ctr=4'b1100;
    end
endmodule
