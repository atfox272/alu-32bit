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
  `ifdef ADDER_INVERT_INPUT_2
  input invert_i_2,        // Invert input 2
  `endif
  `ifdef ADDER_ENABLE_PIN
  input enable,		   // enable the adder  
  `endif
  output [WIDTH - 1:0] o   // Output
  `ifdef ADDER_OVERFLOW_FLAG
  ,output overflow_flag    // Output is overflowed
  `endif
  `ifdef ADDER_ZERO_FLAG
  ,output zero_flag	   // Output is equal to zero
  `endif
  `ifdef ADDER_EXCEPTION_FLAG
  ,output exception_flag   // Exception case
  `endif
);

wire [WIDTH - 1:0] carry;
wire [WIDTH - 1:0] sum;
wire [WIDTH - 1:0] i_1_in;
wire [WIDTH - 1:0] i_2_in;

`ifdef ADDER_ENABLE_PIN
assign i_1_in = (enable) ? i_1 : {WIDTH{1'b0}};
assign i_2_in = (enable) ? i_2 : {WIDTH{1'b0}};
`else 
assign i_1_in = i_1;
assign i_2_in = i_2;
`endif
assign o = sum;
assign zero_flag = sum == {WIDTH{1'b0}};
assign exception_flag = overflow_flag;
`ifdef ADDER_INVERT_INPUT_2
assign overflow_flag = (invert_i_2) ? (((~i_1_in[WIDTH - 1]) & (i_2_in[WIDTH - 1]) & (o[WIDTH - 1])) | ((i_1_in[WIDTH - 1]) & (~i_2_in[WIDTH - 1]) & (~o[WIDTH - 1]))) : carry[WIDTH - 1];
`else
assign overflow_flag = carry[WIDTH - 1];
`endif

generate
for (genvar i = 0; i < WIDTH; i = i + 1) begin
  if (i == 0) begin
    full_adder i_full_adder (
      .i_1(i_1_in[i]),
      .i_2(i_2_in[i]),
      .i_3(1'b0),
      `ifdef ADDER_INVERT_INPUT_2
      .invert_i_2(invert_i_2),
      `endif
      .s(sum[i]),
      .c(carry[i])
    );
  end
  else begin
    full_adder i_full_adder (
      .i_1(i_1_in[i]),
      .i_2(i_2_in[i]),
      .i_3(carry[i - 1]),
      `ifdef ADDER_INVERT_INPUT_2
      .invert_i_2(invert_i_2),
      `endif
      .s(sum[i]),
      .c(carry[i])
    );
  end
end
endgenerate

endmodule
