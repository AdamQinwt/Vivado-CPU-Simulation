`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2019/04/29 21:49:51
// Design Name: 
// Module Name: IFID
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


module IFID(
    input clock,
    input reset,
    
    input[31:0] in_INS,
    output[31:0] out_INS,
    input[31:0] in_PCp4,
    output[31:0] out_PCp4
    );
    reg[31:0] INS;
    reg[31:0] PCp4;
    assign out_PCp4=PCp4;
    assign out_INS=INS;
    always@(negedge clock)
    begin
        if(reset)
        begin
            INS=0;
            PCp4=0;
        end
        else
        begin
            INS=in_INS;
            PCp4=in_PCp4;
        end
    end
endmodule
