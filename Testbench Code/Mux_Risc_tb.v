module mux2_tb();

reg [31:0] in0, in1;
reg sel;
wire [31:0] out;

mux2_1 uut (out, in0, in1, sel);

initial
begin
$monitor($time , " in0=%h, in1=%h, sel=%b, out=%h ", in0, in1, sel, out);
#5 in0=32'hFFFF0001; sel=0;
#5 in1=32'h01FFFCCE; sel=1;

#20 $finish;
end

endmodule