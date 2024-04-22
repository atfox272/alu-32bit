// Name: Decoder
// Description: Decoder (n) to (1 << n). The binary inputs determine which output line from o[0] to o[1 << n - 1] is “HIGH” at logic level “1” while the remaining outputs are held “LOW” at logic “0” (with ACTIVE == 1)

`include "decoder_define.h" 

module decoder
#(
  parameter IN_WIDTH = 5, // Input width
  parameter ACTIVE = 1    // Active HIGH/LOW (1/0)
)
(
  input [IN_WIDTH - 1:0] i,
`ifdef DECODER_ENABLE_PIN
  input enable,
`endif
  output [(1 << IN_WIDTH) - 1:0] o
);

wire [IN_WIDTH - 1:0] i_in;

`ifdef DECODER_ENABLE_PIN
assign i_in = (enable) ? i : {IN_WIDTH{1'b0}};
`else
assign i_in = i;
`endif
generate 
  for (genvar idx = 0; idx < (1 << IN_WIDTH); idx = idx + 1) begin
    assign o[idx] = (i_in == idx) ? ACTIVE[0] : ~ACTIVE[0];
  end
endgenerate

endmodule
