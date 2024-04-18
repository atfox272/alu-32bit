// Name: Half adder
// Description:
`include "adder_define.h"
module half_adder (
  input i_1, // Input 1
  input i_2, // Input 2
  `ifdef ADDER_INVERT_INPUT_2
  input invert_i_2,
  `endif
  output s,  // Sum
  output c   // Carry
);

assign s = i_2 ^ i_1;
`ifdef ADDER_INVERT_INPUT_2
assign c = i_2 & (invert_i_2 ? ~i_1 : i_1);
`else 
assign c = i_2 & i_1;
`endif

endmodule 
