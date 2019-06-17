`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2019/04/29 20:56:22
// Design Name: 
// Module Name: MEM
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


module MEM(
    input clock,
    input reset,
    
    input[31:0] in_branchdst,
    output[31:0] out_branchdst,
    
    input in_regwrite,  //wb
    output out_regwrite,  //wb
    input in_memtoreg,  //wb
    output out_memtoreg,    //wb
    
    input memread,
    input memwrite,
    input zero,
    input isBranch,
    input[31:0] in_address,
    input[31:0] writedata,
    input[4:0] in_writedst,
    
    output [4:0] out_writedst,
    output PCsrc,
    output[31:0] out_address,
    output[31:0] data
    );
    reg[31:0] reg_data;
    reg[4:0] reg_writedst;
    reg takebranch;
    reg[31:0] branchdst;
    reg [31:0] memory[0:63];
    assign data=reg_data;
    assign out_branchdst=branchdst;
    assign out_writedst=reg_writedst;
    assign out_memtoreg=in_memtoreg;
    assign PCsrc=takebranch;
    assign out_address=in_address;
    assign out_regwrite=in_regwrite;
    
    always@(posedge clock)
    begin
        if(reset)
            begin
            reg_data=0;
            reg_writedst=0;
            takebranch=0;
            branchdst=0;
        end
        begin
            takebranch=zero&isBranch;
            reg_writedst=in_writedst;
            branchdst=in_branchdst;
            //code to access memory
            if(memread)
            begin
                reg_data=memory[in_address];
            end
            if(memwrite)
            begin
                memory[in_address]=writedata;
            end
        end
    end
endmodule
