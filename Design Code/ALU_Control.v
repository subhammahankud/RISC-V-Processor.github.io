// Designing ALU Control for RISC-V(Single Cycle Processor)

`timescale 1ns/1ns
module ALU_Control(ALU_ControlOut, ALU_OpIn, func7, func3);

// port declarations.
input [1:0] ALU_OpIn;
input [31:25]  func7;
input [14:12]  func3;
output reg [3:0] ALU_ControlOut;


always @(*)
begin
case({ALU_OpIn, func7, func3})
12'b00_0000000_000:ALU_ControlOut=4'b0010;
12'b01_0000000_000:ALU_ControlOut=4'b0110;
12'b10_0000000_000:ALU_ControlOut=4'b0010;
12'b10_0100000_000:ALU_ControlOut=4'b0110;
12'b10_0000000_111:ALU_ControlOut=4'b0000;
12'b10_0000000_110:ALU_ControlOut=4'b0001;
default:ALU_ControlOut=4'b1111;
endcase
end

endmodule