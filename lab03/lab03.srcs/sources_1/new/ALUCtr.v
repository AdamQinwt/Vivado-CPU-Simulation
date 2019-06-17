module ALUCtr(
    input [1:0] aluOp,
    input [5:0] func,
    input [5:0] opcode,
    output[3:0] aluCtrOut
    );
    reg [3:0] AluCtrOut;
    always @(aluOp or func)
    begin
        begin
            casex({aluOp,func})
                    8'b00xxxxxx:AluCtrOut=4'b0010;
                    8'bx1xxxxxx:AluCtrOut=4'b0110;
                    8'b1xxx0000:AluCtrOut=4'b0010;
                    8'b1xxx0010:AluCtrOut=4'b0110;
                    8'b1xxx0100:AluCtrOut=4'b0000;
                    8'b1xxx0101:AluCtrOut=4'b0001;
                    8'b1xxx1010:AluCtrOut=4'b0111;
                    8'b1xxx1100:AluCtrOut=4'b0100;
                    8'b1xxx1110:AluCtrOut=4'b0101;
            endcase
            if(opcode==6'b000001)
            begin
                AluCtrOut=4'b0010;
            end
            else if(opcode==6'b000011)
            begin
                AluCtrOut=4'b0000;
            end
            else if(opcode==6'b000101)
            begin
                AluCtrOut=4'b0001;
            end
        end
    end
    assign aluCtrOut=AluCtrOut;
endmodule