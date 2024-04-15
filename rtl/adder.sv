// Name: Adder
// Description: Module Adder is used to add two integers with a width determined by the parameter WIDTH. Additionally, the Adder module can also function as a subtractor module by setting the "invert_i_2" pin. Moreover, the module supports several pins to determine overflow, zero output, etc.

`include "adder_define.h"

module adder 
#(
  parameter WIDTH = 32
)
(
  input [WIDTH - 1:0] i_1, // Input 1
  input [WIDTH - 1:0] i_2, // Input 2
  `ifdef INVERT_INPUT_2
  input invert_i_2,        // Invert input 2
  `endif
  output [WIDTH - 1:0] o   // Output
  `ifdef OVERFLOW_FLAG
  ,output overflow_flag    // Output is overflowed
  `endif
  `ifdef ZERO_FLAG
  ,output zero_flag	   // Output is equal to zero
  `endif
  `ifdef EXCEPTION_FLAG
  ,output exception_flag   // Exception case
  `endif
);

wire [WIDTH - 1:0] carry;
wire [WIDTH - 1:0] sum;

assign o = sum;
assign zero_flag = sum == {WIDTH{1'b0}};
assign exception_flag = overflow_flag;
`ifdef INVERT_INPUT_2
assign overflow_flag = (invert_i_2) ? (((~i_1[WIDTH - 1]) & (i_2[WIDTH - 1]) & (o[WIDTH - 1])) | ((i_1[WIDTH - 1]) & (~i_2[WIDTH - 1]) & (~o[WIDTH - 1]))) : carry[WIDTH - 1];
`else
assign overflow_flag = carry[WIDTH - 1];
`endif
full_adder fa[WIDTH - 1:0];

generate
for (genvar i = 0; i < WIDTH; i = i + 1) begin
  if(i == 0) begin
    assign fa[0].i_1 = i_1[0];
    assign fa[0].i_2 = i_2[0];
    assign fa[0].i_3 = 1'b0;
    `ifdef INVERT_INPUT_2
    assign fa[0].invert_i_2 = invert_i_2;
    `endif
    assign sum[i] = fa[0].s;
    assign carry[i] = fa[0].c;
  end 
  else begin
    assign fa[i].i_1 = i_1[i];
    assign fa[i].i_2 = i_2[i];
    assign fa[i].i_3 = fa[i - 1].c;
    `ifdef INVERT_INPUT_2
    assign fa[i].invert_i_2 = invert_i_2;
    `endif
    assign sum[i] = fa[i].s;
    assign carry[i] = fa[i].c;
  end
end
endgenerate

endmodule
