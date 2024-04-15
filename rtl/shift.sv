// Name: Shift module
// Description: The shift module is used to shift input logic with its width determined by WIDTH parameter. Moreover, The module provides 2 operator of shifting, including shift left logic and shift right logic
module shift
#(
  parameter WIDTH = 32,
  parameter SHAMT_WIDTH = $clog2(WIDTH) // Do not pass value into this parameter
)
(
  input [WIDTH - 1:0] i_1,  // Input 1
  input [SHAMT_WIDTH - 1:0] shamt,// Shift Amount
  input shope,  // Shift Operation (1-left/0-right)
  output [WIDTH - 1:0] o // Output
);

wire [WIDTH - 1:0] shamt_left_dec [WIDTH - 1:0];
wire [WIDTH - 1:0] shamt_right_dec [WIDTH - 1:0];

assign o = (shope) ? shamt_left_dec[shamt] : shamt_right_dec[shamt];
generate 
for(genvar i = 0; i < WIDTH; i = i + 1) begin
  assign shamt_left_dec[i] = i_1 << i;
  assign shamt_right_dec[i] = i_1 >> i;
end
endgenerate

endmodule
