// Name: ALU 
// Description: 32bit ALU with AND, OR, ADD, SUB, SHIFT 
module alu
#(
  parameter DATA_WIDTH = 32,
  parameter ALU_CTRL_WIDTH = 4
)
(
  input [DATA_WIDTH - 1:0] i_1, // Input 1
  input [DATA_WIDTH - 1:0] i_2, // Input 2
  input [ALU_CTRL_WIDTH - 1:0] alu_ctrl, // ALU control lines
  output [DATA_WIDTH - 1:0] o,
  output zero
);



endmodule
