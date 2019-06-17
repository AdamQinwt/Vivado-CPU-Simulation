`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2019/04/29 22:33:37
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
    input regclock,
    output[7:0] out,
    input RESET
    );
    
    
    wire STALL;
    
    wire[31:0] BRANCHDST;
    wire PCSRC;
    wire[31:0] INS_IF_OUT;
    wire[31:0] INS_ID_IN;
    wire[31:0] INS_ID_OUT;
    wire[31:0] PCP4_IF_OUT;
    
    wire[31:0] PCP4_ID_IN;
    wire[31:0] PCP4_ID_OUT;
    wire WB_TO_ID_REGWRITE;
    wire[31:0] WB_TO_ID_WRITEDATA;
    wire[4:0] WB_TO_ID_WRITEDST;
    wire[31:0] SIGNEXT_ID_OUT;
    wire[31:0] A_ID_OUT;
    wire[31:0] B_ID_OUT;
    wire REGWRITE_ID_OUT;
    wire MEMTOREG_ID_OUT;
    wire MEMREAD_ID_OUT;
    wire MEMWRITE_ID_OUT;
    wire BRANCH_ID_OUT;
    wire ALRSRC_ID_OUT;
    wire[1:0] ALUOP_ID_OUT;
    wire REGDST_ID_OUT;
    IF s1(
        .reset(RESET),
        .clock(regclock),
        .branch_dst(BRANCHDST),
        .PCsrc(PCSRC),
        .out_INS(INS_IF_OUT),
        .PCP4(PCP4_IF_OUT)
    );
    ID s2(
        .reset(RESET),
        .clock(regclock),
        .in_INS(INS_ID_IN),
        .out_INS(INS_ID_OUT),
        .in_PCp4(PCP4_ID_IN),
        .out_PCp4(PCP4_ID_OUT),
        .in_regwrite(WB_TO_ID_REGWRITE),
        .in_write_data(WB_TO_ID_WRITEDATA),
        .in_writedst(WB_TO_ID_WRITEDST),
        .sign_ext(SIGNEXT_ID_OUT),
        .a(A_ID_OUT),
        .b(B_ID_OUT),
        .out_regwrite(REGWRITE_ID_OUT),
        .out_memtoreg(MEMTOREG_ID_OUT),
        .out_memread(MEMREAD_ID_OUT),
        .out_memwrite(MEMWRITE_ID_OUT),
        .out_branch(BRANCH_ID_OUT),
        .out_alusrc(ALRSRC_ID_OUT),
        .out_aluop(ALUOP_ID_OUT),
        .out_regdst(REGDST_ID_OUT),
        .out_reg3(out)
    );
    
    wire REGWRITE_EX_IN;
    wire REGWRITE_EX_OUT;
    wire MEMTOREG_EX_IN;
    wire MEMTOREG_EX_OUT;
    wire MEMREAD_EX_IN;
    wire MEMWRITE_EX_IN;
    wire BRANCH_EX_IN;
    wire MEMREAD_EX_OUT;
    wire MEMWRITE_EX_OUT;
    wire BRANCH_EX_OUT;
    wire ALUSRC_EX_IN;
    wire[1:0] ALUOP_EX_IN;
    wire REGDST_EX_IN;
    wire ZERO_EX_OUT;
    wire[31:0] A_EX_IN;
    wire[31:0] B_EX_IN;
    wire[31:0] SIGNEXT_EX_IN;
    wire[4:0] WRITEDST_EX_OUT;
    wire[31:0] ALURESULT_EX_OUT;
    wire[31:0] DATA2_EX_OUT;
    wire[31:0] PCP4_EX_IN;
    wire[31:0] PCP4_EX_OUT;
    wire[31:0] INS_EX_IN;
    wire[31:0] INS_EX_OUT;
    EX s3(
        .reset(RESET),
        .clock(regclock),
        .in_regwrite(REGWRITE_EX_IN),  //wb
        .out_regwrite(REGWRITE_EX_OUT),  //wb
        .in_memtoreg(MEMTOREG_EX_IN),  //wb
        .out_memtoreg(MEMTOREG_EX_OUT),    //wb
        
        .in_memread(MEMREAD_EX_IN),//mem
        .in_memwrite(MEMWRITE_EX_IN),//mem
        .in_branch(BRANCH_EX_IN),//mem
        .out_memread(MEMREAD_EX_OUT),//mem
        .out_memwrite(MEMWRITE_EX_OUT),//mem
        .out_branch(BRANCH_EX_OUT),//mem
        
        .alusrc(ALUSRC_EX_IN),
        .aluop(ALUOP_EX_IN),
        .regdst(REGDST_EX_IN),
        
        .A(A_EX_IN),
        .b(B_EX_IN),
        .sign_ext(SIGNEXT_EX_IN),
        .write_dst(WRITEDST_EX_OUT),
        .alu_result(ALURESULT_EX_OUT),
        .zero(ZERO_EX_OUT),
        .data2(DATA2_EX_OUT),
        
        .in_PCP4(PCP4_EX_IN),
        .out_PCdst(PCP4_EX_OUT),
        .in_INS(INS_EX_IN),
        .out_INS(INS_EX_OUT)
    );
    wire[31:0] PCP4_MEM_IN;
    wire REGWRITE_MEM_IN;
    wire REGWRITE_MEM_OUT;
    wire MEMTOREG_MEM_IN;
    wire MEMTOREG_MEM_OUT;
    wire MEMREAD_MEM_IN;
    wire MEMWRITE_MEM_IN;
    wire ZERO_MEM_IN;
    wire ISBRANCH_MEM_IN;
    wire[31:0] ADDRESS_MEM_IN;
    wire[31:0] WRITEDATA_MEM_IN;
    wire[4:0] WRITEDST_MEM_IN;
    wire[4:0] WRITEDST_MEM_OUT;
    wire[31:0] ADDRESS_MEM_OUT;
    wire[31:0] DATA_MEM_OUT;
    MEM s4(
        .reset(RESET),
        .clock(regclock),
        .out_branchdst(BRANCHDST),
        .PCsrc(PCSRC),
        .in_branchdst(PCP4_MEM_IN),
        
        .in_regwrite(REGWRITE_MEM_IN),  //wb
        .out_regwrite(REGWRITE_MEM_OUT),  //wb
        .in_memtoreg(MEMTOREG_MEM_IN),  //wb
        .out_memtoreg(MEMTOREG_MEM_OUT),    //wb
        
        .memread(MEMREAD_MEM_IN),
        .memwrite(MEMWRITE_MEM_IN),
        .zero(ZERO_MEM_IN),
        .isBranch(ISBRANCH_MEM_IN),
        .in_address(ADDRESS_MEM_IN),
        .writedata(WRITEDATA_MEM_IN),
        .in_writedst(WRITEDST_MEM_IN),
        
        .out_writedst(WRITEDST_MEM_OUT),
        .out_address(ADDRESS_MEM_OUT),
        .data(DATA_MEM_OUT)
    );
    wire MEMTOREG_WB_IN;
    wire REGWRITE_WB_IN;
    wire[31:0] REGDATA_WB_IN;
    wire[31:0] MEMDATA_WB_IN;
    wire[4:0] REGDST_WB_IN;
    WB s5(
        .reset(RESET),
        .clock(regclock),
        .memToReg(MEMTOREG_WB_IN),
        .in_regwrite(REGWRITE_WB_IN),
        .out_regwrite(WB_TO_ID_REGWRITE),
        .regdata(REGDATA_WB_IN),
        .memdata(MEMDATA_WB_IN),
        .writedata(WB_TO_ID_WRITEDATA),
        .in_regdst(REGDST_WB_IN),
        .out_regdst(WB_TO_ID_WRITEDST)
    );
    IFID pr1(
        .reset(RESET),
        .clock(regclock),
        .in_INS(INS_IF_OUT),
        .in_PCp4(PCP4_IF_OUT),
        
        .out_INS(INS_ID_IN),
        .out_PCp4(PCP4_ID_IN)
        
    );
    IDEX pr2(
        .reset(RESET),
        .clock(regclock),
        .in_INS(INS_ID_OUT),
        .in_PCp4(PCP4_ID_OUT),
        .in_signext(SIGNEXT_ID_OUT),
        .in_a(A_ID_OUT),
        .in_b(B_ID_OUT),
        .in_regwrite(REGWRITE_ID_OUT),
        .in_memtoreg(MEMTOREG_ID_OUT),
        .in_memread(MEMREAD_ID_OUT),
        .in_memwrite(MEMWRITE_ID_OUT),
        .in_isBranch(BRANCH_ID_OUT),
        .in_alusrc(ALRSRC_ID_OUT),
        .in_aluop(ALUOP_ID_OUT),
        .in_regdst(REGDST_ID_OUT),
        
        .out_regwrite(REGWRITE_EX_IN),  //wb
        .out_memtoreg(MEMTOREG_EX_IN),  //wb
        
        .out_memread(MEMREAD_EX_IN),//mem
        .out_memwrite(MEMWRITE_EX_IN),//mem
        .out_isBranch(BRANCH_EX_IN),//mem
        
        .out_alusrc(ALUSRC_EX_IN),
        .out_aluop(ALUOP_EX_IN),
        .out_regdst(REGDST_EX_IN),
        
        .out_a(A_EX_IN),
        .out_b(B_EX_IN),
        .out_signext(SIGNEXT_EX_IN),
        .out_PCp4(PCP4_EX_IN),
        .out_INS(INS_EX_IN)
    );
    EXMEM p3(
        .reset(RESET),
        .clock(regclock),
        .in_regwrite(REGWRITE_EX_OUT),  //wb
        .in_memtoreg(MEMTOREG_EX_OUT),    //wb
        
        .in_memread(MEMREAD_EX_OUT),//mem
        .in_memwrite(MEMWRITE_EX_OUT),//mem
        .in_isBranch(BRANCH_EX_OUT),//mem
        
        .in_writedst(WRITEDST_EX_OUT),
        .in_aluresult(ALURESULT_EX_OUT),
        .in_zero(ZERO_EX_OUT),
        .in_data(DATA2_EX_OUT),
        .out_regwrite(REGWRITE_MEM_IN),  //wb
        .out_memtoreg(MEMTOREG_MEM_IN),    //wb
        
        .out_memread(MEMREAD_MEM_IN),//mem
        .out_memwrite(MEMWRITE_MEM_IN),//mem
        .out_isBranch(ISBRANCH_MEM_IN),//mem
        
        .out_writedst(WRITEDST_MEM_IN),
        .out_aluresult(ADDRESS_MEM_IN),
        .out_zero(ZERO_MEM_IN),
        .out_data(WRITEDATA_MEM_IN),
        
        .out_branch_dst(PCP4_MEM_IN),
        
        .in_branch_dst(PCP4_EX_OUT)
    );
    MEMWB p4(
        .reset(RESET),
        .clock(regclock),
        .in_regwrite(REGWRITE_MEM_OUT),  //wb
        .out_regwrite(REGWRITE_WB_IN),  //wb
        .in_memtoreg(MEMTOREG_MEM_OUT),  //wb
        .out_memtoreg(MEMTOREG_WB_IN),    //wb
        
        .in_reg(WRITEDST_MEM_OUT),
        .out_reg(REGDST_WB_IN),
        
        .in_memdata(DATA_MEM_OUT),
        .in_regdata(ADDRESS_MEM_OUT),
        .out_regdata(REGDATA_WB_IN),
        .out_memdata(MEMDATA_WB_IN)
    );
endmodule
