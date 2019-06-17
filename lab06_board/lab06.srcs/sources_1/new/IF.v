`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2019/04/29 20:56:22
// Design Name: 
// Module Name: IF
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


module IF(
    input clock,
    input reset,
    input[31:0] branch_dst,
    input PCsrc,
    output[31:0] out_INS,
    output[31:0] PCP4
    );
    reg[31:0] INS;
    assign out_INS=INS;
    reg[31:0] PC;
    reg [31:0] instructions[0:63];
    reg[2:0] REG_IN_USE[0:31];
    reg[1:0] STALL;
    reg[4:0] r1,r2,w;
    reg w_valid;
    reg[5:0] i;
    reg conflict;
    assign PCP4=PC+4;
    always@(posedge clock)
    begin
        if(reset)
        begin
            for(i=0;i<32;i=i+1)
            begin
                REG_IN_USE[i]=0; 
            end
            conflict=1;
            STALL=0;
            PC=0;
            INS=0;
        end
        else
        begin
            for(i=0;i<32;i=i+1)
            begin
                if(REG_IN_USE[i]!=0) REG_IN_USE[i]=REG_IN_USE[i]+1; 
            end
            if(STALL)
            begin
                STALL=STALL+1;
                INS=32'h00000000;
            end
            else
            begin
                //读取下一条指令，若存在冲突，则记录并发出nop指令
                if(!conflict) PC=STALL?PC:(PCsrc?branch_dst:PCP4);
                //INS=instructions[PC>>2];
                INS=32'b00000000001000100001100000100000;
                //冲突判断
                conflict=0;
                if(INS[31:26]==6'b100011)    //lw
                begin
                    w=INS[20:16];
                    w_valid=1;
                    r1=INS[25:21];
                    r2=INS[20:16];
                    if(REG_IN_USE[r1]>0)
                    begin
                        conflict=1;
                    end
                end
                else if(INS[31:26]==6'b101011)   //sw
                begin
                    w_valid=0;
                    r1=INS[25:21];
                    if(REG_IN_USE[r1]>0)
                    begin
                        conflict=1;
                    end
                end
                else if(INS[31:26]==6'b000000)   //R
                begin
                    w=INS[15:11];
                    w_valid=1;
                    r1=INS[25:21];
                    r2=INS[20:16];
                    if(REG_IN_USE[r1]>0||REG_IN_USE[r2]>0)
                    begin
                        conflict=1;
                    end
                end
                else if(INS[31:26]==6'b000100)  //beq
                begin
                    w_valid=0;
                    r1=INS[25:21];
                    r2=INS[20:16];
                    if(REG_IN_USE[r1]>0||REG_IN_USE[r2]>0)
                    begin
                        conflict=1;
                    end
                    else
                    begin
                        STALL=2'd1;
                    end
                end
                else if(INS[31:26]==6'b000010)  //jump
                begin
                    conflict=1;
                    w_valid=0;
                    PC={PCP4[31:28],INS[25:0]<<2};
                end
                if(conflict)
                begin
                    INS=32'h00000000;
                end
                else
                begin
                    //记录冲突
                    if(w_valid) REG_IN_USE[w]=4;
                end
            end
            //detect RAW hazards
        end
    end
endmodule
