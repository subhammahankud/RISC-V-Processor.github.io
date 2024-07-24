// Designing Control Unit for RISC-V(Single Cycle Processor)
`timescale 1ns/1ns

module Control_Unit(Instruction_Opcode, Branch, MemRead, MemtoReg, ALU_OpOut, MemWrite, ALUSrc, RegWrite, reset);

// port declarations.
input reset;
input [6:0] Instruction_Opcode;
output reg Branch, MemRead, MemtoReg, MemWrite, ALUSrc, RegWrite;
output reg [1:0] ALU_OpOut;



always @(*)
begin

if(reset)
begin
{ALUSrc, MemtoReg, RegWrite, MemRead, MemWrite, Branch, ALU_OpOut} <= 7'b0000000;
end

else
begin
case(Instruction_Opcode)
7'b0110011:begin          // for R type instructions.
           ALUSrc<=0;
           MemtoReg<=0;
		   RegWrite<=1;
		   MemRead<=0;
		   MemWrite<=0;
		   Branch<=0;
		   ALU_OpOut[1]<=1;
		   ALU_OpOut[0]<=0;
		   end
7'b0000011:begin         // for ld type instructions.
           ALUSrc<=1;
           MemtoReg<=1;
		   RegWrite<=1;
		   MemRead<=1;
		   MemWrite<=0;
		   Branch<=0;
		   ALU_OpOut[1]<=0;
		   ALU_OpOut[0]<=0;
		   end
7'b0100011:begin        // for sd type instructions.
           ALUSrc<=1;
           MemtoReg<=1;
		   RegWrite<=0;
		   MemRead<=0;
		   MemWrite<=1;
		   Branch<=0;
		   ALU_OpOut[1]<=0;
		   ALU_OpOut[0]<=0;
		   end
7'b1100011:begin       // for beq type instructions.
           ALUSrc<=0;
           MemtoReg<=1;
		   RegWrite<=0;
		   MemRead<=0;
		   MemWrite<=0;
		   Branch<=1;
		   ALU_OpOut[1]<=0;
		   ALU_OpOut[0]<=1;
		   end
default:begin       // for R type instructions.
        ALUSrc<=0;
        MemtoReg<=0;
		RegWrite<=1;
		MemRead<=0;
		MemWrite<=0;
		Branch<=0;
		ALU_OpOut[1]<=1;
		ALU_OpOut[0]<=0;
		end
endcase
end
end
endmodule
