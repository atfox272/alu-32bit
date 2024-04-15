// Name: Bitwise AND
// Description:
module and_bitwise 
#(
  parameter WIDTH = 32
)
(
  input [WIDTH - 1:0] i_1,// Input 1
  input [WIDTH - 1:0] i_2,// Input 2
  output [WIDTH - 1:0] o  // Output
);

assign o = i_1 & i_2;

endmodule
