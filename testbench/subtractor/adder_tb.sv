// Name: Testbench of Adder module
// Description: Combine Adder with Inverter to make Subtractor
//`define ALL_CASES

`include "adder_define.h"
`define SOME_CASES

module adder_tb;

localparam WIDTH = 32;

reg signed [WIDTH - 1:0] i_1;
reg signed [WIDTH - 1:0] i_2;
reg invert_i_2;

wire signed  [WIDTH - 1:0] o;
wire zero_flag;
wire exception_flag;
wire overflow_flag;

adder #(
  .WIDTH(WIDTH)
) adder_test (
  .i_1(i_1),
  .i_2(i_2),
  .invert_i_2(invert_i_2),
`ifdef ENABLE
  .enable(1'b1),
`endif
  .o(o),
  .overflow_flag(overflow_flag),
  .zero_flag(zero_flag),
  .exception_flag(exception_flag)
);

initial begin
  i_1 <= 0;
  i_2 <= 0;
  invert_i_2 <= 0;
end
`ifdef ALL_CASES
initial begin
  for(integer i = 0; i < 40000; i = i + 100) begin
    i_1 <= i;
    for(integer x = i; x < 40000; x = x + 100) begin
      #1 i_2 <= x;
    end
    if(o != (i_1 - i_2)) begin
      $display("Detect 1 wrong case (%0d | %0d)", i_1, i_2);
      #2 $finish;
    end 
  end
  $display("Run all cases (%0d | %0d)", i_1, i_2);
  #2 $finish;
end
`endif
`ifdef SOME_CASES
reg signed [WIDTH - 1:0] golden_result;
reg golden_overflow;
integer correctness;

initial begin
  invert_i_2 <= 1'b1;
  i_1 <= 32'd15;
  i_2 <= 32'd39;
  #10;
    
  i_1 <= 32'd272;
  i_2 <= 32'd203;
  #10;
  i_1 <= 32'd210;
  i_2 <= 32'd230;
  #10;
  i_1 <= 32'd1;
  i_2 <= 32'd0;
  #10;
  i_1 <= 32'd0;
  i_2 <= 32'd1000;
  #10;
  i_1 <= 32'd32;
  i_2 <= 32'd64;
  #10;
  i_1 <= 2<<32 - 2;
  i_2 <= 2;
  
  #10;
  i_1 <= (2<<32) - 2;
  i_2 <= (2<<32) - 3;
  
  #5 $finish;
end
initial begin
  $display("  Input 1   |   Input 2   |     Dif     |  Overflow   |  Golden Dif | Correctness |");
end
always @(i_1, i_2, invert_i_2) begin
  #1;
  golden_result = i_1 - i_2;
  correctness = (o == golden_result);
  #2 $display("%11d | %11d | %11d | %11b | %11d | %11d |", i_1, i_2, o, overflow_flag, golden_result, correctness);
end
`endif

endmodule
