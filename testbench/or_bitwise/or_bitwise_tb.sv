// Name: Testbench of Bitwise AND module

`include "or_bitwise_define.h"

module or_bitwise_tb;

localparam WIDTH = 32;
reg [WIDTH - 1:0] i_1;
reg [WIDTH - 1:0] i_2;
reg enable;
wire [WIDTH - 1:0] o;

or_bitwise ob_t(
  .i_1(i_1),
  .i_2(i_2),
  `ifdef OR_BITWISE_ENABLE_PIN
  .enable(enable),
  `endif 
  .o(o)
);

initial begin
  i_1 <= 32'b0;
  i_2 <= 32'b0;
end

initial begin
  `ifdef OR_BITWISE_ENABLE_PIN
  enable <= 1'b1;
  `endif
  #1 
  i_1 <= 32'b1001010011111;
  i_2 <= 32'b0101111010010;
  #2
  i_1 <= 32'b11111111111111111111111111111111;
  i_2 <= 32'b10101000010010010010010100100101;
  #2
  i_1 <= 32'b11111111111111111111111111111111;
  i_2 <= 32'b11111111111111111111111111111111;
  #2
  i_1 <= 32'b11101000000000000001100100000000;
  i_2 <= 32'b11111111111111111111111111111111;
  #2
  i_1 <= 32'b11111111111111111111111111111111;
  i_2 <= 32'b00000000000000000000000000000000;
  #2
  i_1 <= 32'b11111111100011111110100101001011;
  i_2 <= 32'b11111111111111000100101000111111;
  #2;
  `ifdef OR_BITWISE_ENABLE_PIN
  enable <= 1'b0;
  `endif
  #2
  i_1 <= 32'b11111111101001010010000111111111;
  i_2 <= 32'b10000000000000000000000000000111;
  #2
  i_1 <= 32'b11111111111111111111111111111111;
  i_2 <= 32'b11111111111111111111111111111111;
end


always @(i_1, i_2) begin
  #1
  $display("Input 1: %32b", i_1);
  $display("Input 2: %32b", i_2);
  $display("Enable : %32b", enable);
  $display("Output : %32b", o);
 $display("---------------------------------------");
end


endmodule
