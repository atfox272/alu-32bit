// Name: Testbench of shift module
module shift_tb;

localparam WIDTH = 32;
localparam SHAMT_WIDTH = $clog2(WIDTH);
reg [WIDTH - 1:0] i_1;
reg [SHAMT_WIDTH - 1:0] shamt;
reg shope;
wire [WIDTH - 1:0] o;

shift shift_test(
  .i_1(i_1),
  .shamt(shamt),
  .shope(shope),
  .o(o)
);

initial begin
  i_1 <= 32'b0;
  shamt <= 5'd0;
  shope <= 0;
end

initial begin
  #1 
  i_1 <= 32'd3;
  shamt <= 5'd2;
  shope <= 1'b1; // shift left

  #4 
  i_1 <= 32'd3;
  shamt <= 5'd2;
  shope <= 1'b0; // shift right


 #4 
  i_1 <= 32'd27;
  shamt <= 5'd5;
  shope <= 1'b1; // shift left


 #4 
  i_1 <= 32'd10000;
  shamt <= 5'd6;
  shope <= 1'b0; // shift right


 #4 
  i_1 <= 32'd3;
  shamt <= 5'd15;
  shope <= 1'b1; // shift left


 #4 
  i_1 <= 32'd4;
  shamt <= 5'd9;
  shope <= 1'b0; // shift right


 #4 
  i_1 <= 32'hFFF000;
  shamt <= 5'd22;
  shope <= 1'b1; // shift left

// Add Testcase here 

  #10 $finish;
end

reg [WIDTH - 1:0] golden_result;
integer correctness;
initial begin
  $display("    Input   | Shift Amount| 1-sll/0-srl |    Result   |Golden Result| Correctness");
end
always @(i_1, shamt, shope) begin
  #1;
  golden_result = (shope) ? i_1 * (2**shamt) : i_1 / (2**shamt);
  correctness = (o == golden_result);
	$display("%11d | %11d | %11d | %11d | %11d | %11d", i_1, shamt, shope, o, golden_result, correctness);
end

endmodule
