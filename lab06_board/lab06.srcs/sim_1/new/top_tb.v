`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2019/04/30 09:40:57
// Design Name: 
// Module Name: top_tb
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


module top_tb(

    );
    reg clock;
    reg reg_reset;
    top t(
        .regclock(clock),
        .RESET(reg_reset)
    );
    always #(20) clock=!clock;
    initial begin
        clock=1'b0;
        reg_reset=1;
        #50;
        reg_reset=0;
        $readmemh("E:/archlabs/lab6/data",t.s4.memory,10'h0);
        $readmemb("E:/archlabs/lab6/ins",t.s1.instructions,10'h0);
    end
endmodule
