// Name: Bitwise AND
// Description:

`include "and_bitwise_define.h"

module and_bitwise 
#(
  parameter WIDTH = 32
)
(
  input [WIDTH - 1:0] i_1,// Input 1
  input [WIDTH - 1:0] i_2,// Input 2
  `ifdef ENABLE
  input enable,
  `endif 
  output [WIDTH - 1:0] o  // Output
);

wire [WIDTH - 1:0] i_1_in;
wire [WIDTH - 1:0] i_2_in;

`ifdef ENABLE
assign i_1_in = (enable) ? i_1 : {WIDTH{1'b0}};
assign i_2_in = (enable) ? i_2 : {WIDTH{1'b0}};
`else
assign i_1_in = i_1;
assign i_2_in = i_1;
`endif
assign o = i_1_in & i_2_in;

endmodule
