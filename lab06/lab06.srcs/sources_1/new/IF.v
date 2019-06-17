`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2019/04/17 09:20:59
// Design Name: 
// Module Name: InstMemory
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

/*
module InstMemory(
    input clock,
    input [31:0] pc,
    output [31:0] instruction
    );
    reg[31:0] instruction;
    reg [31:0] im[0:63];
    always @ (clock)
    begin
        assign instruction=im[pc];
    end
    //assign instruction=instruction;
endmodule
*/

module IF(
    input clock,
    output [31:0] instruction,
	input[31:0] branch_add,
	input isBranch,
	input isJump,
	input zero,
	input reset
    );
    reg[31:0] instruction;
    reg [31:0] im[0:63];
    reg[31:0] PCP4,JP,BRADD;
    wire takebranch;
    reg[31:0] pc;
 //   assign BRADD=PCP4+(branch_add<<2);
 //   assign JP=((instruction&32'h03ffffff)<<2)|(PCP4&32'hf000);
 //   assign PCP4=pc+4;
    always @ (posedge clock)
    begin
        instruction=im[pc>>2];
        PCP4=pc+4;
        BRADD=PCP4+(branch_add<<2);
        JP=((instruction&32'h03ffffff)<<2)|(PCP4&32'hf0000000);
    end
    always @ (negedge clock)
    begin
        pc=isJump?JP:(takebranch?BRADD:PCP4);
    end
    always @(negedge reset)
    begin
        pc<=32'h00000000;
    end
and(takebranch,isBranch,zero);
endmodule




