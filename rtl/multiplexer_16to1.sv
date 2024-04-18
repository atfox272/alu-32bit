// Name: Multiplexer (16-to-1)
// Description: 16to1 Multiplexer
module multiplexer_16to1
#(
  parameter IN_WIDTH = 32
)
(
  input [IN_WIDTH - 1:0] in_0, // Input
  input [IN_WIDTH - 1:0] in_1, // Input
  input [IN_WIDTH - 1:0] in_2, // Input
  input [IN_WIDTH - 1:0] in_3, // Input
  input [IN_WIDTH - 1:0] in_4, // Input
  input [IN_WIDTH - 1:0] in_5, // Input
  input [IN_WIDTH - 1:0] in_6, // Input
  input [IN_WIDTH - 1:0] in_7, // Input 
  input [IN_WIDTH - 1:0] in_8, // Input
  input [IN_WIDTH - 1:0] in_9, // Input
  input [IN_WIDTH - 1:0] in_10, // Input
  input [IN_WIDTH - 1:0] in_11, // Input
  input [IN_WIDTH - 1:0] in_12, // Input
  input [IN_WIDTH - 1:0] in_13, // Input
  input [IN_WIDTH - 1:0] in_14, // Input
  input [IN_WIDTH - 1:0] in_15, // Input
  input [3:0] sel,// Select 
  output [IN_WIDTH - 1:0] out // Output
);

assign out = (sel == 4'b0000) ? in_0 :
	     (sel == 4'b0001) ? in_1 :
	     (sel == 4'b0010) ? in_2 :
	     (sel == 4'b0011) ? in_3 :
	     (sel == 4'b0100) ? in_4 :
	     (sel == 4'b0101) ? in_5 :
	     (sel == 4'b0110) ? in_6 :
	     (sel == 4'b0111) ? in_7 :
	     (sel == 4'b1000) ? in_8 :
	     (sel == 4'b1001) ? in_9 :
	     (sel == 4'b1010) ? in_10 :
	     (sel == 4'b1011) ? in_11 :
	     (sel == 4'b1100) ? in_12 :
	     (sel == 4'b1101) ? in_13 : 
	     (sel == 4'b1110) ? in_14 : in_15;

endmodule

