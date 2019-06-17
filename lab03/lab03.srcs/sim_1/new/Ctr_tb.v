
    
    module Ctr_tb(

    );
    wire RegDst;
    wire ALUSrc;
    wire MemToReg;
    wire RegWrite;
    wire MemWrite;
    wire Branch;
    wire [1:0] ALUOp;
    wire Jump;
    reg[5:0] OpCode;
    Ctr u0(/*
        .regDst(RegDst),
        .aluSrc(ALUSrc),
        .memToReg(MemToReg),
        .regWrite(RegWrite),
        .memRead(MemRead),
        .memWrite(MemWrite),
        .branch(Branch),
        .aluOp(ALUOp),
        .jump(Jump),
        .opcode(OpCode)
        */
        .regDst(RegDst),
        .aluSrc(ALUSrc),
        .memToReg(MemToReg),
        .regWrite(RegWrite),
        .memRead(MemRead),
        .memWrite(MemWrite),
        .branch(Branch),
        .aluOp(ALUOp),
        .jump(Jump),
        .opcode(OpCode)
       /* .RegDst(regDst),
        .ALUSrc(aluSrc),
        .MemToReg(memToReg),
        .RegWrite(regWrite),
        .MemRead(memRead),
        .MemWrite(memWrite),
        .Branch(branch),
        .ALUOp(aluOp),
        .Jump(jump),
        .OpCode(opcode)*/
       /* .regDst(regDst),
        .aluSrc(aluSrc),
        .memToReg(memToReg),
        .regWrite(regWrite),
        .memRead(memRead),
        .memWrite(memWrite),
        .branch(branch),
        .aluOp(ALUOp),
        .jump(jump),
        .opcode(OpCode)*/
        
    );
    
    initial begin
        OpCode=0;
       /* assign RegDst=regDst;
        assign ALUSrc=aluSrc;
        assign MemToReg=memToReg;
        assign RegWrite=regWrite;
        assign MemRead=memRead;
        assign MemWrite=memWrite;
        assign Branch=branch;
        assign ALUOp=aluOp;
       // assign ALUOp[0]=aluOp[0];
       // assign ALUOp[1]=aluOp[1];
        assign Jump=jump;*/
        #100;
        #100 OpCode=6'b000000;
        #100 OpCode=6'b100011;
        #100 OpCode=6'b101011;
        #100 OpCode=6'b000100;
        #100 OpCode=6'b000010;
        
    end
endmodule