// Name: Testbench of decoder module

`include "decoder_define.h"

module decoder_tb;

localparam IN_WIDTH = 5;

reg [IN_WIDTH - 1:0] i;
reg enable;
wire [(1<<IN_WIDTH) - 1:0] o;

decoder #(
  .IN_WIDTH(IN_WIDTH),  // Decoder 4to16
  .ACTIVE(1'b1)		// Active HIGH
) dt (
  .i(i),
`ifdef ENABLE
  .enable(enable),
`endif
  .o(o)
);

initial begin
  i <= 0;

end

initial begin
  $display("    Input    |    Ouptut  ");
  #1;
  for(integer idx = 0; idx < (1 << IN_WIDTH); idx = idx + 1) begin
    #3; i <= idx;
  end
  #5; $finish;	  
end

always @(i) begin
  #1; $display(" %11d | %32b ", i, o);
end

endmodule
