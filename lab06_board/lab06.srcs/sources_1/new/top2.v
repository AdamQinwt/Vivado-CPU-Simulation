`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2019/05/05 08:32:02
// Design Name: 
// Module Name: top2
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


module top2(
    input clk_p,
    input clk_n,
    output led_clk,
    output led_do,
    output led_en,
    output wire seg_clk,
    output wire seg_en,
    output wire seg_do,
    input reset
    );
    wire clk_25M;
    wire clk_i;
    wire[7:0] cpu_out;
    reg[1:0] clk_div;
    always@(posedge clk_i)
    begin
        clk_div<=clk_div+1;
    end
    assign clk_25M=clk_div[1];
    IBUFGDS i(
        .O(clk_i),
        .I(clk_p),
        .IB(clk_n)
    );
    top t(
        .regclock(clk_div[1]),
        .out(cpu_out),
        .RESET(reset)
    );
    display dis(
        .clk(clk_25M),
        .rst(1'b0),
        .en(8'b00000111),
        .data({24'b0,cpu_out}),
        .dot(8'b00000000),
        .led(~{7'b0,cpu_out}),
        .led_clk(led_clk),
        .led_en(led_en),
        .led_do(led_do),
        .seg_clk(seg_clk),
        .seg_en(seg_en),
        .seg_do(seg_do)
    );
endmodule
