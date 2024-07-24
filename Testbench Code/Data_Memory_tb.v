// Testbench for Data Memory for RISC-V(Single Cycle Processor)

module Data_Memory_tb();

// port declarations.
reg MemWrite, MemRead, clk, reset;
reg [31:0] Write_data, address; 
wire [31:0] Read_data;
 
Data_Memory uut(Read_data, Write_data, MemWrite, MemRead, address, clk, reset);


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
//$dumpfile("Data_Memory.vcd");
//$dumpvars(0,Data_Memory_tb);
$monitor($time , " reset=%b, clk=%b, Read_data=%h, Write_data=%h, MemWrite=%b, MemRead=%b, address=%h ", reset, clk, Read_data, Write_data, MemWrite, MemRead, address);

#20 MemRead=1; address=25;
#20 Write_data=32'hffff0001; MemWrite=1; MemRead=0; address=25;
#20 MemWrite=0; MemRead=1; address=25;
#20 MemRead=1; address=27;
#10 $finish;
end

endmodule



