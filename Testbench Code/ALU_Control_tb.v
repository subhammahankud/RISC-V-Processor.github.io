// TestBench for ALU Control for RISC-V(Single Cycle Processor)

module ALU_Control_tb();

// port declarations.
reg [1:0] ALU_OpIn;
reg [31:25]  func7;
reg [14:12]  func3;
wire [3:0] ALU_ControlOut;

ALU_Control uut(ALU_ControlOut, ALU_OpIn, func7, func3);

initial
begin
$dumpfile("ALU_Control");
$dumpvars(0,ALU_Control_tb);
$monitor($time , " ALU_OpIn=%b, func7=%b, func3=%b, ALU_ControlOut=%b ", ALU_OpIn, func7, func3, ALU_ControlOut);
#5 ALU_OpIn=2'b00; func7=7'b0000000; func3=3'b000; 
#5 ALU_OpIn=2'b01; func7=7'b0000000; func3=3'b000; 
#5 ALU_OpIn=2'b10; func7=7'b0000000; func3=3'b000; 
#5 ALU_OpIn=2'b10; func7=7'b0100000; func3=3'b000; 
#5 ALU_OpIn=2'b10; func7=7'b0000000; func3=3'b111;
#5 ALU_OpIn=2'b10; func7=7'b0000000; func3=3'b110;  

#5 $finish;
end


endmodule