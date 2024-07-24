// Designing Instruction Memory for RISC-V(Single Cycle Processor)

`timescale 1ns/1ns 
module Instruction_Memory(Instruction_out, read_address, clk, reset);

// port declarations.
input clk, reset;
input [31:0]read_address; //Reading Instruction Address sent PC.
output [31:0]Instruction_out;
 
//Making Memory
reg [31:0] InstructionMemory [31:0]; //considering PC 32-bit, memory consists of 31 cells each of 32 bit wide.

assign Instruction_out = InstructionMemory[read_address]; //Assigning Memory value.
integer i;

always @(posedge clk)
begin
if(reset == 1'b1)
begin
for(i = 0; i < 32; i = i+1)
InstructionMemory[i] = 32'b0; //Initialize when reset.
end
else if(reset == 1'b0)
begin
InstructionMemory[4] = 32'b0000000_00010_00001_000_00001_0110011; // add R1, R1, R2
InstructionMemory[8] = 32'b0100000_00010_00001_000_00001_0110011; // sub R1, R1, R2
InstructionMemory[12] = 32'b0000000_00010_00001_111_00001_0110011; // and R1, R1, R2
InstructionMemory[16] = 32'b0000000_00010_00001_110_00001_0110011; // or R1, R1, R2
InstructionMemory[20] = 32'b000000000111_00010_000_00001_0000011; //  ld R1, 0(R2)
InstructionMemory[24] = 32'b0000000_00001_00010_000_00011_0100011; // sd R1, 0(R2)
InstructionMemory[28] = 32'b0000000_00010_00001_000_11111_1100011; // beq R1, R2, offset
end
end
endmodule
