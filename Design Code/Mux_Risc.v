module mux2_1(out, in0, in1, sel);

// port declarations
input [31:0] in0, in1;
input sel;
output [31:0] out;

assign out = sel ? in1 : in0;
 
endmodule
