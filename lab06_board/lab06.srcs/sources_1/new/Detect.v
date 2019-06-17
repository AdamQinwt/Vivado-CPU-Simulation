`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2019/04/30 09:11:09
// Design Name: 
// Module Name: Detect
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


module Detect(
    input clock,
    input[31:0] INS,
    output stall
    );
    reg reg_stall;
    reg[2:0] used[31:0];
    reg current_used;
    assign stall=reg_stall;
    always@(negedge clock)
    begin
        reg_stall=1'b0;
        //get the currently used reg
        //look it up in the used table
        //output stall
    end
endmodule
