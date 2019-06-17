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


module ALUCtr_tb(

    );
    reg[1:0] aluOp;
    reg[5:0] func;
    wire[3:0] AluCtrOut;
    ALUCtr u1(
        .aluOp(aluOp),
        .func(func),
        .aluCtrOut(AluCtrOut)
    );
     initial begin
        aluOp=2'b00;
        func=6'b000000;
        #25;
        aluOp=2'b00;// func=6'b100011;
        #25;
        //aluOp=2'bx1;// func=6'b100011;
        aluOp=2'b01;
        #25;
        //aluOp=2'b1x; func=6'bxx0000;
        aluOp=2'b10; func=6'b000000;
        #25;
        //aluOp=2'b1x; func=6'bxx0010;
        aluOp=2'b10; func=6'b000010;
        #50;
        //aluOp=2'b1x; func=6'bxx0100;
        aluOp=2'b10; func=6'b000100;
        #50;
        //aluOp=2'b1x; func=6'bxx0101;
        aluOp=2'b10; func=6'b000101;
        #50;
        //aluOp=2'b1x; func=6'bxx1010;
        aluOp=2'b10; func=6'b001010;
        
    end
endmodule
