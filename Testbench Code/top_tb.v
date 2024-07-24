module Top_tb();

// port declarations.
reg clk, reset;

Top uut(clk, reset);

//clock generations.
initial
begin
clk=0;
end

always #20 clk = ~clk;

//reset generations.
initial
begin
reset=1'b1;
#10 reset=1'b0;
end

initial
begin
$dumpfile("Top.vcd");
$dumpvars(0,Top_tb);
#400 $finish;
end



endmodule