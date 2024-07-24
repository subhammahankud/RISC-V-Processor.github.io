// Designing Register File for RISC-V(Single Cycle Processor)

`timescale 1ns/1ns
module Register_File(Read_data1, Read_data2, Write_data, Read_register1,
Read_register2, Write_register, RegWrite, clk, reset);

// port declarations.
input RegWrite, clk, reset;
input [19:15] Read_register1;
input [24:20] Read_register2;
input [11:7]  Write_register;
input [31:0]  Write_data;
output [31:0] Read_data1, Read_data2;

//Making Register File
reg [31:0] Registers [31:0]; // 32 Registers each of 32-bit wide.
integer i;

initial
begin
for(i = 0; i < 32; i = i + 1)
begin
Registers[i] = i*10;
end
end

always @(posedge clk) // Assigning values with  write control signal.
begin 
if(reset == 1'b1)
begin
for(i = 0; i < 32; i = i + 1)
begin
Registers[i] = 32'h00000000;
end
end
else if(RegWrite == 1'b1)
begin
Registers[Write_register] = Write_data;
end
end

assign Read_data1 = Registers[Read_register1];  // Assigning values with no read control signal.
assign Read_data2 = Registers[Read_register2];  // Assigning values with no read control signal.

endmodule


