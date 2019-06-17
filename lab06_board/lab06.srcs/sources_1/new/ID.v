`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2019/04/29 20:56:22
// Design Name: 
// Module Name: ID
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
    input clock,
    input reset,
    output[7:0] out_reg3,
    input[31:0] in_INS,
    output[31:0] out_INS,
    input[31:0] in_PCp4,
    output[31:0] out_PCp4,
    
    input in_regwrite,
    input[31:0] in_write_data,
    input[4:0] in_writedst,
    
    output[31:0] sign_ext,
    output[31:0] a,
    output[31:0] b,

    output out_regwrite,  //wb
    output out_memtoreg,    //wb
    
    output out_memread,//mem
    output out_memwrite,//mem
    output out_branch,//mem
    
    output out_alusrc,  //ex
    output[1:0] out_aluop, //ex
    output out_regdst //ex
    
    );
    reg alusrc;  //ex
    reg[1:0] aluop; //ex
    reg regdst; //ex
    reg regwrite;  //wb
    reg regmemtoreg;    //wb
    reg memread;//mem
    reg memwrite;//mem
    reg isbranch;//mem
    reg[31:0] reg_signext;
    reg[31:0] reg_a;
    reg[31:0] reg_b;
    reg[31:0] INS;
    reg[31:0] PCp4;
    reg[31:0] registers[31:0];
    reg[5:0] i;
    assign out_reg3=registers[3][7:0];
    assign a=reg_a;
    assign b=reg_b;
    assign out_memread=memread;
    assign out_memwrite=memwrite;
    assign out_branch=isbranch;
    assign out_regwrite=regwrite;
    assign out_memtoreg=regmemtoreg;
    assign out_alusrc=alusrc;
    assign out_aluop=aluop;
    assign out_regdst=regdst;
    assign out_INS=INS;
    assign out_PCp4=PCp4;
    assign sign_ext=reg_signext;
    always@(posedge clock)
    begin
        if(reset)
        begin
            for(i=0;i<32;i=i+1)
        begin
            registers[i]=0;
        end
            alusrc=0;
            aluop=0;
            regdst=0;
            regwrite=0;
            regmemtoreg=0;
            memread=0;
            memwrite=0;
            isbranch=0;
            reg_signext=0;
            reg_a=0;
            reg_b=0;
            INS=0;
            PCp4=0;
        end
        else
        begin
            INS=in_INS;
            PCp4=in_PCp4;
            if(in_regwrite)
            begin
                registers[in_writedst]=in_write_data;
                registers[2]=32'h00000001;
            end
            //logic to solve the control signals
            case(INS[31:26])
                6'b000000:  //R
                begin
                    alusrc=0;
                    aluop=2'b10;
                    regdst=1;
                    regwrite=1;
                    regmemtoreg=0;
                    memread=0;
                    memwrite=0;
                    isbranch=0;
                end
                6'b100011:  //lw
                begin
                    alusrc=1;
                    aluop=2'b00;
                    regdst=0;
                    regwrite=1;
                    regmemtoreg=1;
                    memread=1;
                    memwrite=0;
                    isbranch=0;
                end
                6'b101011:  //sw
                begin
                    regdst=0;
                    alusrc=1;
                    regmemtoreg=1;
                    regwrite=0;
                    memread=0;
                    memwrite=1;
                    isbranch=0;
                    aluop=2'b00;
                end
                6'b000100:  //beq
                begin
                    regdst=0;
                    alusrc=0;
                    regmemtoreg=1;
                    regwrite=0;
                    memread=0;
                    memwrite=0;
                    isbranch=1;
                    aluop=2'b01;
                end
                default:
                begin
                    regdst=0;
                    alusrc=0;
                    regmemtoreg=0;
                    regwrite=0;
                    memread=0;
                    memwrite=0;
                    isbranch=0;
                    aluop=2'b00;
                end
            endcase
            //logic for the reg file
            reg_a=registers[INS[25:21]];
            reg_b=registers[INS[20:16]];
            //logic for the sign extend
            reg_signext=INS[15]?(32'hffff0000|INS[15:0]):(32'h0000ffff&INS[15:0]);
        end
    end
endmodule
