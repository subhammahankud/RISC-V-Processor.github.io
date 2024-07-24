// Testbench for Register File for RISC-V(Single Cycle Processor)

module Register_File_tb();

// port declarations.
reg RegWrite, clk, reset;
reg [19:15] Read_register1;
reg [24:20] Read_register2;
reg [11:7]  Write_register;
reg [31:0]  Write_data;
wire [31:0] Read_data1, Read_data2;

Register_File uut(Read_data1, Read_data2, Write_data, Read_register1,
Read_register2, Write_register, RegWrite, clk, reset);

//clock generations.
initial
begin
clk=1;
end

always #10 clk = ~clk;

//reset generations.
initial
begin
reset=1'b0;
#10 reset=1'b0;
end

initial
begin
//$dumpfile("Register_File.vcd");
//$dumpvars(0,Register_File_tb);
$monitor($time , " reset=%b, clk=%b, Rd1=%d, Rd2=%d, Wd=%d, Rs1=%d, Rs2=%d, Ws=%d, RW=%b", reset, clk, Read_data1, Read_data2, Write_data, Read_register1,Read_register2, Write_register, RegWrite);

#20 RegWrite=0; Read_register1=0; Read_register2=1; 
#20 RegWrite=0; Read_register1=1; Read_register2=19;
#20 RegWrite=1; Read_register1=25; Write_register=25; Write_data=1025; 
#20 RegWrite=1; Read_register1=10; Write_register=10; Write_data=100025;
#20 RegWrite=1; Read_register1=10; Read_register2=12; Write_register=12; Write_data=6545;

#10 $finish;
end

endmodule
