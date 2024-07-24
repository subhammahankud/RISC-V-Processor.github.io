// Designing Program Counter(PC) for RISC-V(Single Cycle Processor)

`timescale 1ns/1ns 
module Program_Counter(PC_OUT, PC_IN, clk, reset);

// port declarations.
input clk, reset;
input [31:0]PC_IN; 
output reg [31:0]PC_OUT;

always @(posedge clk or posedge reset) //PC and reset is triggered at positive edge of clock.
begin
if(reset==1'b1)
PC_OUT <= 0; //reset is high initialize PC_OUT with zero.
else
PC_OUT <= PC_IN;
end

endmodule