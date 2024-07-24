// Designing  Branch target for RISC-V(Single Cycle Processor)

`timescale 1ns/1ns 
module Branch_Target(Branch_target, Imm_Gen_out, PC_from_Next);

// port declarations.
input [31:0] Imm_Gen_out;
input [31:0] PC_from_Next; 
output [31:0] Branch_target;

assign Branch_target = (Imm_Gen_out << 1) + PC_from_Next;

endmodule