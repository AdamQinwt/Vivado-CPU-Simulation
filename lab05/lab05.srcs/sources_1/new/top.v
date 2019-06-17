`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2019/04/17 09:24:11
// Design Name: 
// Module Name: top
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


module top(
    input reset,
    input cl,
    input clk_n,
    input clk_p,
    input i1,
    input i2,
    output wire seg_clk,
    output wire seg_en,
    output wire seg_do,
    output led_clk,
    output led_do,
    output led_en
    );
    wire REG_DST,JUMP,BRANCH,MEM_READ,MEM_TO_REG,MEM_WRITE,ZERO;
    wire[1:0] ALU_OP;
    wire ALU_SRC,REG_WRITE;
    wire[31:0] INS;
    wire[31:0] A,B,RES,aluB;
    wire[31:0] memData,sign_ext;
    wire[31:0] WRITE_BACK_DATA;
    wire[4:0] WRITE_REG;
    wire[3:0] out;
    wire clock1,clock2;
    assign clock2=cl;
    reg[1:0] div;
    always@(posedge cl)
    begin
        div<=div+1;
    end
    assign clock1=div[1];
    InstMemory im(
        .in({i1,i2}),
        .clock(clock1),
        .instruction(INS),
        .branch_add(sign_ext),
        .isBranch(BRANCH),
        .isJump(JUMP),
        .zero(ZERO),
        .reset(reset)
    );
    MUX5 writeCtr(
        .in1(INS[20:16]),
        .in2(INS[15:11]),
        .out(WRITE_REG),
        .sel(REG_DST)
    );
    MUX writeDataCtr(
        .in1(RES),
        .in2(memData),
        .out(WRITE_BACK_DATA),
        .sel(MEM_TO_REG)
    );
    MUX aluBSrc(
        .in1(B),
        .in2(sign_ext),
        .out(aluB),
        .sel(ALU_SRC)
    );
    Ctr ctr(
        .opcode(INS[31:26]),
        .regDst(REG_DST),
        .jump(JUMP),
        .branch(BRANCH),
        .memRead(MEM_READ),
        .memWrite(MEM_WRITE),
        .memToReg(MEM_TO_REG),
        .aluOp(ALU_OP),
        .aluSrc(ALU_SRC),
        .regWrite(REG_WRITE)
    );
    ALU_COMP alu_comp(
         .a(A),
         .b(aluB),
         .op(ALU_OP),
         .opcode(INS[31:26]),
         .func(INS[5:0]),
         .result(RES),
         .zero(ZERO)
    );
    Registers register(
        .readReg1(INS[25:21]),
        .readReg2(INS[20:16]),
        .writeReg(WRITE_REG),
        .writeData(WRITE_BACK_DATA),
        .regWrite(REG_WRITE),
        .reset(reset),
        .readData1(A),
        .readData2(B),
        .test_out(out),
        .clock(clock2)
    );
    
    memory dm(
        .clock(clock2),
        .address(RES),
        .writeData(B),
        .readData(memData),
        .memRead(MEM_READ),
        .memWrite(MEM_WRITE)
    );
    signext sign(
        .inst(INS[15:0]),
        .data(sign_ext)
    );
    
    wire CLK_i;
wire Clk_25M;
IBUFGDS IBUFGDS_inst(
    .O(CLK_i),
    .I(clk_p),
    .IB(clk_n)
);
//assign out=4'b0111;
reg [1:0] clkdiv;
    always@(posedge CLK_i)
    clkdiv<=clkdiv+1;
assign Clk_25M=clkdiv[1];
display DISPLAY (
       .clk(Clk_25M),
          .rst(1'b0),
             .en(8'hff),
                .data({28'b0,out}),
              //  .data(32'b1),
                   .dot(8'b00000000),
                      .led(~{28'b0,out}),
                  //    .led(~(32'b1)),
                         .led_clk(led_clk),
                            .led_en(led_en),
                               .led_do(led_do),
                                  .seg_clk(seg_clk),
                                     .seg_en(seg_en),
                              .seg_do(seg_do)  
    );
endmodule
