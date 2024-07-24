// Designing ALU for RISC-V(Single Cycle Processor)

`timescale 1ns/1ps
module ALU(ALU_Result, ALU_Control, ALU_In1, ALU_In2, Zero);

// port declarations.
input [31:0] ALU_In1, ALU_In2;
input [3:0]  ALU_Control;
output reg [31:0] ALU_Result;
output reg  Zero;

always @(*)
begin
case(ALU_Control)
4'b0000:begin Zero <= 0; ALU_Result <= ALU_In1 & ALU_In2; end
4'b0001:begin Zero <= 0; ALU_Result <= ALU_In1 | ALU_In2; end
4'b0010:begin {Zero,ALU_Result} <= ALU_In1 + ALU_In2; end
4'b0110:begin {Zero,ALU_Result} <= ALU_In1 - ALU_In2; end
default:begin Zero <= 0; ALU_Result <= 0; end
endcase
end

endmodule