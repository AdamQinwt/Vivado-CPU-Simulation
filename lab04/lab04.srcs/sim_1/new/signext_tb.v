`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2019/04/17 08:49:52
// Design Name: 
// Module Name: signext_tb
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


module signext_tb(

    );
    wire[31:0] data;
    reg[15:0] inst;
    signext ext(
        .data(data),
        .inst(inst)
    );
    initial begin
        inst=16'h8123;
        #100;
        inst=16'h0000;
        #100;
        inst=16'hffff;
    end
endmodule
