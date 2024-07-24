// Testbench for Instruction Memory for RISC-V(Single Cycle Processor)

 
module Instruction_Memory_tb();

// port declarations.
reg clk, reset;
reg [31:0]read_address; //Reading Instruction Address sent PC.
wire [31:0]Instruction_out;

Instruction_Memory uut(Instruction_out, read_address, clk, reset);
 
//clock generations.
initial
begin
clk=1;
end

always #10 clk = ~clk;

//reset generations.
initial
begin
reset=1'b1;
#10 reset=1'b0;
end

initial
begin
//$dumpfile("Instruction_Memory.vcd");
//$dumpvars(0,Instruction_Memory_tb);
$monitor($time , " reset=%b, clk=%b, read_address=%h, Instruction_out=%h ", reset, clk, read_address, Instruction_out);
//#20 read_address=32'h00000000;
#20 read_address=32'h00000004;
#20 read_address=32'h00000008;
#20 read_address=32'h0000000C;
#20 read_address=32'h00000010;
#20 read_address=32'h00000014;
#20 read_address=32'h00000018;
#20 read_address=32'h0000001C;

#10 $finish;
end

endmodule