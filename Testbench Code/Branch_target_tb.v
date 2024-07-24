// Testbench for Branch target for RISC-V(Single Cycle Processor)
 
module Branch_Target_tb();

// port declarations.
reg [31:0] Imm_Gen_out;
reg [31:0] PC_from_Next; 
wire [31:0] Branch_target;

Branch_Target uut(Branch_target, Imm_Gen_out, PC_from_Next);

initial
begin
//$dumpfile("Branch_Target");
//$dumpvars(0,Branch_Target_tb);
$monitor($time , " Imm_Gen_out=%h, PC_from_Next=%h, Branch_target=%h ", Imm_Gen_out, PC_from_Next, Branch_target);
#5 Imm_Gen_out=32'h00000001; PC_from_Next=32'h00000001;
#5 Imm_Gen_out=32'h00000010; PC_from_Next=32'h00000001;
#5 Imm_Gen_out=32'h00000100; PC_from_Next=32'h00000001;
#5 Imm_Gen_out=32'h00001000; PC_from_Next=32'h00000001;

#5 $finish;
end

endmodule