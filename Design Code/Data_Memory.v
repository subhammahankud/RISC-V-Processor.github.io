// Designing Data Memory for RISC-V(Single Cycle Processor)

`timescale 1ns/1ns 

module Data_Memory(Read_data, Write_data, MemWrite, MemRead, address, clk, reset);

// port declarations.
input MemWrite, MemRead, clk, reset;
input [31:0] Write_data, address; 
output [31:0] Read_data;
 
//Making Memory
reg [31:0] DataMemory [31:0];
//considering address 32-bit, data memory consists of 32 cells each of 32 bit wide.

assign Read_data= (MemRead) ? DataMemory[address] : 32'h00000000; //Assigning DataMemory value.
integer i;

always @(posedge clk or posedge reset)
begin
if(reset == 1'b1)
begin
for(i=0;i<32;i=i+1)
begin
DataMemory[i] = i*20; //Initialize when reset.
end
end
else if(MemWrite)
begin
DataMemory[address]=Write_data;
end
end

endmodule

