// Designing Immediate Generator for RISC-V(Single Cycle Processor)

`timescale 1ns/1ns 
module Immediate_Generator(Imm_Gen, Instruction, Opcode);

// port declarations.
input [6:0] Opcode;
input [31:0] Instruction; 
output reg [31:0] Imm_Gen;

always @(*)
begin
case(Opcode)
7'b0000011:Imm_Gen <= {{20{Instruction[31]}}, Instruction[31:20]}; // ld type Instruction.
7'b0100011:Imm_Gen <= {{20{Instruction[31]}}, Instruction[31:25], Instruction[11:7]}; // sd type Instruction.
7'b1100011:Imm_Gen <= {{20{Instruction[31]}}, Instruction[31], Instruction[7], Instruction[30:25], Instruction[11:8]}; // beq type Instruction.
default:Imm_Gen <= 32'h00000000;
endcase
end 

endmodule