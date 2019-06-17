module PC_Ctr(
	output[31:0] newpc,
	input[31:0] oldpc,
	input[25:0] jadd,
	input[31:0] branch_add,
	input isBranch,
	input isJump,
	input zero
);
wire[31:0] PCP4,JP,BP,BRADD;
wire takebranch;
assign PCP4=oldpc+4;
assign BRADD=PCP4+(branch_add<<2);
assign JP=(jadd<<2)|(PCP4&32'hf000);
MUX branchctr(
	.in1(PCP4),
	.in2(BRADD),
	.out(BP),
	.sel(takebranch)
);
MUX jumpctr(
	.in1(BP),
	.in2(JP),
	.out(newpc),
	.sel(isJump)
);
and(takebranch,isBranch,zero);
endmodule