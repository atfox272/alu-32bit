// Name: Shift module
// Description: The shift module is used to shift input logic with its width determined by WIDTH parameter. Moreover, The module provides 2 operator of shifting, including shift left logic and shift right logic

`include "shift_define.h"

module shift
#(
  parameter WIDTH = 32,
  parameter SHAMT_WIDTH = $clog2(WIDTH) // Do not pass value into this parameter
)
(
  input [WIDTH - 1:0] i_1,  // Input 1
  input [SHAMT_WIDTH - 1:0] shamt,// Shift Amount
  input shope,  // Shift Operation (1-left/0-right)
  `ifdef ENABLE
  input enable, 
  `endif 
  output [WIDTH - 1:0] o // Output
);

wire [WIDTH - 1:0] i_1_in;
wire [WIDTH - 1:0] shamt_in;
wire shope_in;
wire [WIDTH - 1:0] shamt_left_dec [WIDTH - 1:0];
wire [WIDTH - 1:0] shamt_right_dec [WIDTH - 1:0];

`ifdef ENABLE
assign i_1_in = (enable) ? i_1 : {WIDTH{1'b0}};
assign shamt_in = (enable) ? shamt : {SHAMT_WIDTH{1'b0}};
assign shope_in = (enable) ? shope : 1'b0;
`else
assign i_1_in = i_1;
assign shamt_in = shamt;
assign shope_in = shope;
`endif
assign o = (shope_in) ? shamt_left_dec[shamt_in] : shamt_right_dec[shamt_in];
generate 
for(genvar i = 0; i < WIDTH; i = i + 1) begin
  assign shamt_left_dec[i] = i_1_in << i;
  assign shamt_right_dec[i] = i_1_in >> i;
end
endgenerate

endmodule
