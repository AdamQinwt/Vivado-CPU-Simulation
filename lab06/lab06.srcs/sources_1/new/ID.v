`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2019/04/28 19:22:14
// Design Name: 
// Module Name: WB
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


module ID(
    input[31:0] INS,
    input[31:0] in_PCP4,  //没用
    output[31:0] out_PCP4,  //没用
    output regDst,
    output aluSrc,
    output memToReg,
    output out_regWrite,
    output memRead,
    output memWrite,
    output branch,
    output [1:0] aluOp,
    output jump,
    input [25:21] readReg1,
    input [20:16] readReg2,
    input [4:0] writeReg,
    input [31:0] writeData,
    input in_regWrite,
    input reset,
    output [31:0] readData1,
    output [31:0] readData2,
    output [31:0] sign_ext_data,
    output [31:0] INS_out,  //直接将指令往下传
    input clock
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
    reg[31:0] sign_data;
    reg[5:0] OpCode;
    assign INS_out=INS;
    always @(INS)
    begin
        assign OpCode=INS[31:26];
        case(OpCode)
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
    assign out_regWrite=RegWrite;
    assign memRead=MemRead;
    assign memWrite=MemWrite;
    assign branch=Branch;
   // assign aluOp[0]=ALUOp[0];
   // assign aluOp[1]=ALUOp[1];
   assign aluOp=ALUOp;
    assign jump=Jump;
    reg [31:0] regFile[31:0];
    reg[31:0] readData1;
    reg[31:0] readData2;
    reg[5:0] i;
always @ (negedge clock)
	begin
	   readData1=regFile[readReg1];
		readData2=regFile[readReg2];
		if(in_regWrite==1'b1)
		begin
              regFile[writeReg]=writeData;
		end
	end
always @(negedge reset)
	 for(i=0;i<32;i=i+1)
	      regFile[i]=0;
endmodule
