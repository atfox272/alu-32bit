// Name: Multiplexer (8-to-1)
// Description: 8to1 Multiplexer
module multiplexer_8to1
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
  
  input [2:0] sel,// Select 
  output [IN_WIDTH - 1:0] out // Output
);

assign out = (sel == 3'b000) ? in_0 :
	     (sel == 3'b001) ? in_1 :
	     (sel == 3'b010) ? in_2 :
	     (sel == 3'b011) ? in_3 :
	     (sel == 3'b100) ? in_4 :
	     (sel == 3'b101) ? in_5 :
	     (sel == 3'b110) ? in_6 : in_7;

endmodule

