// Name: Test bench of Full Adder module
`include "adder_define.h"
`define ADD_TB
//`define SUB_TB // Must define INVERT_INPUT_2
module full_adder_tb;

reg i_1;
reg i_2;
reg i_3;
`ifdef INVERT_INPUT_2
reg invert_i_2;
`endif
wire s;
wire c;

full_adder fa(
  .i_1(i_1),
  .i_2(i_2),
  .i_3(i_3),
  `ifdef INVERT_INPUT_2
  .invert_i_2(invert_i_2),
  `endif
  .s(s),
  .c(c)
);

initial begin
  i_1 <= 1'b0;
  i_2 <= 1'b0;
  i_3 <= 1'b0;
end
`ifdef SUB_TB
initial begin
  invert_i_2 <= 1'b1;
  for(integer a = 0; a < 2; a = a + 1) begin
    for(integer b = 0; b < 2; b = b + 1) begin
      for(integer d = 0; d < 2; d = d + 1) begin
        #2 i_1 <= ~i_1;
      end
      i_2 <= ~i_2;
    end 
    i_3 <= ~i_3;
  end
  #4 $finish;
end

initial begin
  $display("a  b  c | d  b");
end

always @(i_1, i_2, i_3) begin 
  #1; $display("%1b  %1b  %1b | %1b  %1b", i_1, i_2, i_3, s, c);
end
`endif
`ifdef ADD_TB
initial begin
  `ifdef INVERT_INPUT_2
  invert_i_2 <= 1'b0;
  `endif
  for(integer a = 0; a < 2; a = a + 1) begin
    for(integer b = 0; b < 2; b = b + 1) begin
      for(integer d = 0; d < 2; d = d + 1) begin
        #2 i_1 <= ~i_1;
      end
      i_2 <= ~i_2;
    end 
    i_3 <= ~i_3;
  end
  #4 $finish;
end

initial begin
  $display("a  b  c | s  c");
end

always @(i_1, i_2, i_3) begin 
  #1; $display("%1b  %1b  %1b | %1b  %1b", i_3, i_2, i_1, s, c);
end
`endif

endmodule
