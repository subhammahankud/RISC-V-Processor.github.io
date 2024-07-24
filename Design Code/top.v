// Designing Program Counter(PC) for RISC-V(Single Cycle Processor)

`timescale 1ns/1ns
 
module Program_Counter(PC_OUT, PC_IN, clk, reset);

// port declarations.
input clk, reset;
input [31:0]PC_IN; 
output reg [31:0]PC_OUT;

always @(posedge clk or posedge reset) //PC and reset is triggered at positive edge of clock.
begin
if(reset)
PC_OUT <= 32'h00000000; //reset is high initialize PC_OUT with zero.
else
PC_OUT <= PC_IN;
end

endmodule

// Designing Program Counter(PC) adder for next Instruction for RISC-V(Single Cycle Processor)

module Program_Counter_Next(PC_OUT_NEXT, PC_IN_NEXT);

// port declarations.
input [31:0] PC_IN_NEXT; 
output [31:0] PC_OUT_NEXT;

assign PC_OUT_NEXT = PC_IN_NEXT + 32'h00000004; 

endmodule

// Designing  Branch target for RISC-V(Single Cycle Processor)

module Branch_Target(Branch_target, Imm_Gen_out, PC_from_Next);

// port declarations.
input [31:0] Imm_Gen_out;
input [31:0] PC_from_Next; 
output [31:0] Branch_target;

assign Branch_target = (Imm_Gen_out << 1) + PC_from_Next;

endmodule

// Designing Instruction Memory for RISC-V(Single Cycle Processor)
 
module Instruction_Memory(Instruction_out, read_address, clk, reset);

// port declarations.
input clk, reset;
input [31:0]read_address; //Reading Instruction Address sent PC.
output [31:0]Instruction_out;
 
//Making Memory
reg [31:0] InstructionMemory [31:0]; //considering PC 32-bit, memory consists of 31 cells each of 32 bit wide.

assign Instruction_out = InstructionMemory[read_address]; //Assigning Memory value.
integer i;

always @(posedge clk)
begin
if(reset == 1'b1)
begin
for(i = 0; i < 32;i = i+1)
InstructionMemory[i] = 32'h00000000; //Initialize when reset.
end
else if(reset == 1'b0)
begin
InstructionMemory[4] = 32'b0000000_00010_00001_000_00001_0110011; // add R1, R1, R2
InstructionMemory[8] = 32'b0100000_00010_00001_000_00001_0110011; // sub R1, R1, R2
InstructionMemory[12] = 32'b0000000_00010_00001_111_00001_0110011; // and R1, R1, R2
InstructionMemory[16] = 32'b0000000_00010_00001_110_00001_0110011; // or R1, R1, R2
InstructionMemory[20] = 32'b000000000111_00010_000_00001_0000011; //  ld R1, offset(R2)
InstructionMemory[24] = 32'b0000000_00001_00010_000_00011_0100011; // sd R1, offset(R2)
InstructionMemory[28] = 32'b0000000_00010_00001_000_11111_1100011; // beq R1, R2, offset
end
end
endmodule

// Designing Register File for RISC-V(Single Cycle Processor)

module Register_File(Read_data1, Read_data2, Write_data, Read_register1,
Read_register2, Write_register, RegWrite, clk, reset);

// port declarations.
input RegWrite, clk, reset;
input [19:15] Read_register1;
input [24:20] Read_register2;
input [11:7]  Write_register;
input [31:0]  Write_data;
output [31:0] Read_data1, Read_data2;

//Making Register File
reg [31:0] Registers [31:0]; // 32 Registers each of 32-bit wide.
integer i;

initial
begin
for(i = 0; i < 32; i = i + 1)
begin
Registers[i] = i*10;
end
end

always @(posedge clk) // Assigning values with  write control signal.
begin 
if(reset == 1'b1)
begin
for(i=0; i<32; i=i+1)
begin
Registers[i] = 32'b0;
end
end
else if(RegWrite == 1'b1)
begin
Registers[Write_register] = Write_data;
end
end

assign Read_data1 = Registers[Read_register1];  // Assigning values with no read control signal.
assign Read_data2 = Registers[Read_register2];  // Assigning values with no read control signal.

endmodule

// Designing Immediate Generator for RISC-V(Single Cycle Processor)
 
module Immediate_Generator(Imm_Gen, Instruction, Opcode);

// port declarations.
input [6:0] Opcode;
input [31:0] Instruction; 
output reg [31:0] Imm_Gen;

always @(*)
begin
case(Opcode)
7'b0000011:Imm_Gen <= {{20{Instruction[31]}}, Instruction[31:20]}; // ld type Instruction.
7'b0100011:Imm_Gen <= {{20{Instruction[31]}}, Instruction[31:25], Instruction[11:7]}; // sd type Instruction.
7'b1100011:Imm_Gen <= {{20{Instruction[31]}}, Instruction[31], Instruction[7], Instruction[30:25], Instruction[11:8]}; // beq type Instruction.
default:Imm_Gen <= 32'h00000000;
endcase
end 

endmodule

// Designing Control Unit for RISC-V(Single Cycle Processor)

module Control_Unit(Instruction_Opcode, Branch, MemRead, MemtoReg, ALU_OpOut, MemWrite, ALUSrc, RegWrite, reset);

// port declarations.
input reset;
input [6:0] Instruction_Opcode;
output reg Branch, MemRead, MemtoReg, MemWrite, ALUSrc, RegWrite;
output reg [1:0] ALU_OpOut;



always @(*)
begin

if(reset)
begin
{ALUSrc, MemtoReg, RegWrite, MemRead, MemWrite, Branch, ALU_OpOut} <= 7'b0000000;
end

else
begin
case(Instruction_Opcode)
7'b0110011:begin          // for R type instructions.
           ALUSrc<=0;
           MemtoReg<=0;
		   RegWrite<=1;
		   MemRead<=0;
		   MemWrite<=0;
		   Branch<=0;
		   ALU_OpOut[1]<=1;
		   ALU_OpOut[0]<=0;
		   end
7'b0000011:begin         // for ld type instructions.
           ALUSrc<=1;
           MemtoReg<=1;
		   RegWrite<=1;
		   MemRead<=1;
		   MemWrite<=0;
		   Branch<=0;
		   ALU_OpOut[1]<=0;
		   ALU_OpOut[0]<=0;
		   end
7'b0100011:begin        // for sd type instructions.
           ALUSrc<=1;
           MemtoReg<=1;
		   RegWrite<=0;
		   MemRead<=0;
		   MemWrite<=1;
		   Branch<=0;
		   ALU_OpOut[1]<=0;
		   ALU_OpOut[0]<=0;
		   end
7'b1100011:begin       // for beq type instructions.
           ALUSrc<=0;
           MemtoReg<=1;
		   RegWrite<=0;
		   MemRead<=0;
		   MemWrite<=0;
		   Branch<=1;
		   ALU_OpOut[1]<=0;
		   ALU_OpOut[0]<=1;
		   end
default:begin       // for R type instructions.
        ALUSrc<=0;
        MemtoReg<=0;
		RegWrite<=1;
		MemRead<=0;
		MemWrite<=0;
		Branch<=0;
		ALU_OpOut[1]<=1;
		ALU_OpOut[0]<=0;
		end
endcase
end
end
endmodule

// Designing ALU for RISC-V(Single Cycle Processor)

module ALU(ALU_Result, ALU_Control, ALU_In1, ALU_In2, Zero);

// port declarations.
input [31:0] ALU_In1, ALU_In2;
input [3:0]  ALU_Control;
output reg [31:0] ALU_Result;
output reg  Zero;

always @(*)
begin
case(ALU_Control)
4'b0000:begin Zero <= 0; ALU_Result <= ALU_In1 & ALU_In2; end
4'b0001:begin Zero <= 0; ALU_Result <= ALU_In1 | ALU_In2; end
4'b0010:begin {Zero,ALU_Result} <= ALU_In1 + ALU_In2; end
4'b0110:begin {Zero,ALU_Result} <= ALU_In1 - ALU_In2; end
default:begin Zero <= 0; ALU_Result <= 0; end
endcase
end

endmodule

// Designing ALU Control for RISC-V(Single Cycle Processor)

module ALU_Control(ALU_ControlOut, ALU_OpIn, func7, func3);

// port declarations.
input [1:0] ALU_OpIn;
input [31:25]  func7;
input [14:12]  func3;
output reg [3:0] ALU_ControlOut;


always @(*)
begin
case({ALU_OpIn, func7, func3})
12'b00_0000000_000:ALU_ControlOut=4'b0010;
12'b01_0000000_000:ALU_ControlOut=4'b0110;
12'b10_0000000_000:ALU_ControlOut=4'b0010;
12'b10_0100000_000:ALU_ControlOut=4'b0110;
12'b10_0000000_111:ALU_ControlOut=4'b0000;
12'b10_0000000_110:ALU_ControlOut=4'b0001;
default:ALU_ControlOut=4'b1111;
endcase
end

endmodule

// Designing Data Memory for RISC-V(Single Cycle Processor)
 
module Data_Memory(Read_data, Write_data, MemWrite, MemRead, address, clk, reset);

// port declarations.
input MemWrite, MemRead, clk, reset;
input [31:0] Write_data, address; 
output [31:0] Read_data;
 
//Making Memory
reg [31:0] DataMemory [31:0];
//considering address 32-bit, data memory consists of 32 cells each of 32 bit wide.

assign Read_data= (MemRead) ? DataMemory[address] : 32'h00000000; //Assigning DataMemory value.
integer i;


always @(posedge clk or posedge reset)
begin
if(reset == 1'b1)
begin
for(i=0;i<32;i=i+1)
begin
DataMemory[i] = i*20; //Initialize when reset.
end
end
else if(MemWrite)
begin
DataMemory[address]=Write_data;
end
end

endmodule

// Designing mux for RISC-V(Single Cycle Processor)

module mux2_1(out, in0, in1, sel);

// port declarations
input [31:0] in0, in1;
input sel;
output [31:0] out;

assign out = sel ? in1 : in0;
 
endmodule

// Designing and gate for RISC-V(Single Cycle Processor)

module and_gate(out, in0, in1);
// port declarations
input in0, in1;
output out;

assign out = in0 & in1;
endmodule

// Designing Top for RISC-V(Single Cycle Processor)

module Top(clk, reset);

// port declarations.
input clk, reset;

// internal wire declarations.
wire [31:0] PC_Top; //wire connect the o/p of PC to PC adder.
wire [31:0] PC_Next_Top; //wire connect the o/p of PC_OUT_NEXT to PC_IN.
wire [31:0] Instruction_out_Top; //wire connect o/p of Instruction_Memory to i/p Register_File.
wire [31:0] Read_data1_Top; //wire connect o/p of Read_data1 to i/p of ALU.
wire [31:0] Read_data2_Top; //wire connect o/p of Read_data2 to i/p of mux1.
wire [31:0] mux1ToAlu; //wire connect o/p of mux1 to i/p of ALU.
wire [3:0] ALU_ControlOut_Top;//wire connect o/p of ALU_Control to i/p of ALU.
wire [31:0] ALU_Result_Top;//wire connect o/p of ALU to i/p of Data_Memory.
wire [31:0] Read_data_Top;//wire connect o/p of Data_Memory to i/p of mux2.
wire [31:0] mux2ToAlu;//wire connect o/p of mux2 to i/p of Register_File.
wire [31:0] Imm_Gen_Top;//wire connect o/p of Immediate_Generator  to i/p of Branch_Target.
wire [31:0] Branch_target_Top;//wire connect o/p of Branch_target to i/p of mux3.
wire [31:0] mux3ToPc;//wire connect o/p of mux3 to i/p of Program_Counter.
wire Branch_control_top, Zero_Top, Branch_Top, RegWrite_Top, ALUSrc_Top, MemWrite_Top, MemRead_Top, MemtoReg_Top;//wire connect o/p of Control_Unit.
wire [1:0] ALU_OpOut_Top;


// Program_Counter_Next instantiations.
Program_Counter_Next Program_Counter_Next_Top(.PC_OUT_NEXT(PC_Next_Top), .PC_IN_NEXT(PC_Top));

//Program_Counter instantiations.
Program_Counter Program_Counter_Top(.PC_OUT(PC_Top), .PC_IN(mux3ToPc), .clk(clk), .reset(reset));

//Instruction_Memory instantiations.
Instruction_Memory Instruction_Memory_Top(.Instruction_out(Instruction_out_Top), .read_address(PC_Top), .clk(clk), .reset(reset));

//Register_File instantiations.
Register_File Register_File_Top(.Read_data1(Read_data1_Top), .Read_data2(Read_data2_Top), .Write_data(mux2ToAlu), .Read_register1(Instruction_out_Top[19:15]),
.Read_register2(Instruction_out_Top[24:20]), .Write_register(Instruction_out_Top[11:7]), .RegWrite(RegWrite_Top), .clk(clk), .reset(reset));

//ALU instantiations.
ALU ALU_Top(.ALU_Result(ALU_Result_Top), .ALU_Control(ALU_ControlOut_Top), .ALU_In1(Read_data1_Top), .ALU_In2(mux1ToAlu), .Zero(Zero_Top));

//mux_1 instantiations.
mux2_1 mux2_1_1_Top(.out(mux1ToAlu), .in0(Read_data2_Top), .in1(Imm_Gen_Top), .sel(ALUSrc_Top));

//ALU_Control instantiations.
ALU_Control ALU_Control_Top(.ALU_ControlOut(ALU_ControlOut_Top), .ALU_OpIn(ALU_OpOut_Top), .func7(Instruction_out_Top[31:25]), .func3(Instruction_out_Top[14:12]));

//Data_Memory instantiations.
Data_Memory Data_Memory_Top(.Read_data(Read_data_Top), .Write_data(Read_data2_Top), .MemWrite(MemWrite_Top), .MemRead(MemRead_Top), .address(ALU_Result_Top), .clk(clk), .reset(reset));

//mux_2 instantiations.
mux2_1 mux2_1_2_Top(.out(mux2ToAlu), .in0(ALU_Result_Top), .in1(Read_data_Top), .sel(MemtoReg_Top));

//Control_Unit instantiations.
Control_Unit Control_Unit_Top(.Instruction_Opcode(Instruction_out_Top[6:0]), .Branch(Branch_Top), .MemRead(MemRead_Top), .MemtoReg(MemtoReg_Top), .ALU_OpOut(ALU_OpOut_Top), .MemWrite(MemWrite_Top), .ALUSrc(ALUSrc_Top), .RegWrite(RegWrite_Top), .reset(reset));

//Immediate_Generator instantiations.
Immediate_Generator Immediate_Generator_Top(.Imm_Gen(Imm_Gen_Top), .Instruction(Instruction_out_Top), .Opcode(Instruction_out_Top[6:0]));


//Branch_Target instantiations.
Branch_Target Branch_Target_Top(.Branch_target(Branch_target_Top), .Imm_Gen_out(Imm_Gen_Top), .PC_from_Next(PC_Top));

//mux_3 instantiations.
mux2_1 mux2_1_3_Top(.out(mux3ToPc), .in0(PC_Next_Top), .in1(Branch_target_Top), .sel(Branch_control_top));

//and gate instantiations.
and_gate and_gate_Top(.out(Branch_control_top), .in0(Branch_Top), .in1(Zero_Top));

endmodule