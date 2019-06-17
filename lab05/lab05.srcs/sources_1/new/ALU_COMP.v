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


module ALU_COMP(
    input[31:0] a,
    input[31:0] b,
    input[1:0] op,
    input[5:0] func,
    input[5:0] opcode,
    output[31:0] result,
    output zero
    );
    wire[3:0] CTR;
    ALUCtr ctr(
        .aluOp(op),
        .func(func),
        .opcode(opcode),
        .aluCtrOut(CTR)
    );
    ALU alu(
        .input1(a),
        .input2(b),
        .ctr(CTR),
        .zero(zero),
        .aluRes(result)
    );
endmodule
