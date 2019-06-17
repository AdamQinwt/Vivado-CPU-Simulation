`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2019/04/17 11:13:35
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
    reg clock1;
    reg clock2;
    reg reset;
    top t(
        .clock1(clock1),
        .clock2(clock2),
        .reset(reset)
    );
    parameter PERIOD1=30,PERIOD2=10;
    always #(PERIOD1) clock1=!clock1;
    always #(PERIOD2) clock2=!clock2;
    initial begin
        $readmemh("E:/archlabs/lab05/data",t.dm.memFile,10'h0);
        $readmemb("E:/archlabs/lab05/ins",t.im.im,10'h0);
        reset=1;
        clock1=0;
        clock2=0;
       // #12;
        reset=0;
        //$readmemh("datafile", t.dm);
        //$readmemh("Instruction",t.im);
        
    end
endmodule
