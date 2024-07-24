// Testbench for Register File for RISC-V(Single Cycle Processor)

module Immediate_Generator_tb();

// port declarations.
reg [6:0] Opcode;
reg [31:0] Instruction; 
wire [31:0] Imm_Gen;

Immediate_Generator uut(Imm_Gen, Instruction, Opcode);

initial
begin
$dumpfile("Immediate_Generator.vcd");
$dumpvars(0,Immediate_Generator_tb);
$monitor($time , " Imm_Gen=%h, Instruction=%h, Opcode=%h",Imm_Gen, Instruction, Opcode);

#20 Instruction=32'b111100001111_00010_000_00001_0000011;  Opcode=7'b0000011;//ld
#20 Instruction=32'b1111111_00001_00010_000_00000_0100011; Opcode=7'b0100011;//sd
#20 Instruction=32'b0000000_00010_00001_000_11111_1100011; Opcode=7'b1100011;//beq

#10 $finish;
end

endmodule
