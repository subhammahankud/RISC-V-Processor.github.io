// Designing Program Counter(PC) adder for next Instruction for RISC-V(Single Cycle Processor)

`timescale 1ns/1ns 
module Program_Counter_Next(PC_OUT_NEXT, PC_IN_NEXT);

// port declarations.
input [31:0] PC_IN_NEXT; 
output [31:0] PC_OUT_NEXT;

assign PC_OUT_NEXT = PC_IN_NEXT + 32'h00000004; 

endmodule