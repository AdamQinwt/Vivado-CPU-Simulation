`timescale 1ns / 1ps
module Ctr(
    input [5:0] opcode,
    output regDst,
    output aluSrc,
    output memToReg,
    output regWrite,
    output memRead,
    output memWrite,
    output branch,
    output [1:0] aluOp,
    output jump
    );
    reg RegDst;
    reg ALUSrc;
    reg MemToReg;
    reg RegWrite;
    reg MemRead;
    reg MemWrite;
    reg Branch;
    reg [1:0] ALUOp;
    reg Jump;
    always @(opcode)
    begin
        case(opcode)
            6'b000000://R type
            begin
                RegDst = 1;
                ALUSrc = 0;
                MemToReg=0;
                RegWrite=1;
                MemRead=0;
                MemWrite=0;
                Branch=0;
                ALUOp=2'b10;
                Jump=0;
            end
            6'b000001://addi
            begin
                RegDst = 0;
                ALUSrc = 1;
                MemToReg=0;
                RegWrite=1;
                MemRead=0;
                MemWrite=0;
                Branch=0;
                ALUOp=2'b00;
                Jump=0;
            end
            6'b000011://andi
            begin
                RegDst = 0;
                ALUSrc = 1;
                MemToReg=0;
                RegWrite=1;
                MemRead=0;
                MemWrite=0;
                Branch=0;
                ALUOp=2'b10;
                Jump=0;
            end
            6'b0000101://ori
            begin
                RegDst = 0;
                ALUSrc = 1;
                MemToReg=0;
                RegWrite=1;
                MemRead=0;
                MemWrite=0;
                Branch=0;
                ALUOp=2'b10;
                Jump=0;
            end
            6'b100011://lw
            begin
                RegDst = 0;
                ALUSrc = 1;
                MemToReg=1;
                RegWrite=1;
                MemRead=1;
                MemWrite=0;
                Branch=0;
                ALUOp=2'b00;
                Jump=0;
            end
            6'b101011://sw
            begin
                ALUSrc = 1;
                RegWrite=0;
                MemRead=0;
                MemWrite=1;
                Branch=0;
                ALUOp=2'b00;
                Jump=0;
            end
            6'b000100://branch
            begin
                ALUSrc = 0;
                RegWrite=0;
                MemRead=0;
                MemWrite=0;
                Branch=1;
                ALUOp=2'b01;
                Jump=0;
            end
            6'b000010://jump
            begin
                RegDst = 0;
                ALUSrc = 0;
                MemToReg=0;
                RegWrite=0;
                MemRead=0;
                MemWrite=0;
                Branch=0;
                ALUOp=2'b00;
                Jump=1;
            end
            default://default
            begin
                RegDst = 0;
                ALUSrc = 0;
                MemToReg=0;
                RegWrite=0;
                MemRead=0;
                MemWrite=0;
                Branch=0;
                ALUOp=2'b00;
                Jump=0;
            end
        endcase
    end
    assign regDst=RegDst;
    assign aluSrc=ALUSrc;
    assign memToReg=MemToReg;
    assign regWrite=RegWrite;
    assign memRead=MemRead;
    assign memWrite=MemWrite;
    assign branch=Branch;
   // assign aluOp[0]=ALUOp[0];
   // assign aluOp[1]=ALUOp[1];
   assign aluOp=ALUOp;
    assign jump=Jump;
endmodule
