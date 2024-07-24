// Designing Testbench for Control Unit for RISC-V(Single Cycle Processor)

module Control_Unit_tb();

// port declarations.
reg reset;
reg [6:0] Instruction_Opcode;
wire Branch, MemRead, MemtoReg, MemWrite, ALUSrc, RegWrite;
wire [1:0] ALU_OpOut;

//Module instantiations
Control_Unit uut(Instruction_Opcode, Branch, MemRead, MemtoReg, ALU_OpOut, MemWrite, ALUSrc, RegWrite, reset);

initial
begin
$dumpfile("Control_Unit.vcd");
$dumpvars(0,Control_Unit_tb);
$monitor($time," reset=%b, Instruction_Opcode=%b, Branch=%b, MemRead=%b, MemtoReg=%b, ALU_OpOut=%b, MemWrite=%b, ALUSrc=%b, RegWrite=%b",
reset, Instruction_Opcode, Branch, MemRead, MemtoReg, ALU_OpOut, MemWrite, ALUSrc, RegWrite);
reset=1'b1;
#5 reset=1'b0;
#5 Instruction_Opcode=7'b0110011;
#5 Instruction_Opcode=7'b0000011;
#5 Instruction_Opcode=7'b0100011;
#5 Instruction_Opcode=7'b1100011;
#5 $finish;
end

endmodule
        
           
		   
