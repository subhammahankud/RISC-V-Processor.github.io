//Testbench for Program Counter(PC) adder for next Instruction for RISC-V(Single Cycle Processor)

module Program_Counter_Next_tb();

// port declarations.
reg [31:0] PC_IN_NEXT; 
wire [31:0] PC_OUT_NEXT;

Program_Counter_Next uut(PC_OUT_NEXT, PC_IN_NEXT);

initial
begin
//$dumpfile("Program_Counter_Next");
//$dumpvars(0,Program_Counter_Next_tb);
$monitor($time , " PC_IN_NEXT=%h, PC_OUT_NEXT=%h ", PC_IN_NEXT, PC_OUT_NEXT);
#5 PC_IN_NEXT=32'hFFCE6798;
#5 PC_IN_NEXT=32'h00000004;
#5 PC_IN_NEXT=32'hFFFF1110;
#5 $finish;
end

endmodule
