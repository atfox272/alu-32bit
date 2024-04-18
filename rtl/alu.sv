// Name: ALU 
// Description: 32bit ALU with AND, OR, ADD, SUB, SHIFT (Shift left & Shift right)
module alu
#(
  parameter DATA_WIDTH = 32,
  parameter ALU_CTRL_WIDTH = 4
)
(
  input [DATA_WIDTH - 1:0] i_1, // Input 1
  input [DATA_WIDTH - 1:0] i_2, // Input 2
  input [ALU_CTRL_WIDTH - 1:0] alu_ctrl, // ALU control lines
  output [DATA_WIDTH - 1:0] o,
  output zero_flag,  // Output is equal to zero
  output exception_flag,  // Exception case
  output overflow_flag // Overflow flag 
);

// Function decode table
localparam ADD_FUNCTION = 4'b0010; // 2
localparam SUB_FUNCTION = 4'b0110; // 6
localparam AND_FUNCTION = 4'b0000; // 0
localparam OR_FUNCTION  = 4'b0001; // 1
localparam SLL_FUNCTION = 4'b1000; // 8
localparam SRL_FUNCTION = 4'b1001; // 9

// Interface of ADDER
wire enable_adder;
wire enable_add;
wire enable_sub;
wire invert_i_2_adder;
wire [DATA_WIDTH - 1:0] o_adder;
wire overflow_adder;
wire exception_adder;
// Interface of Bitwise AND block
wire enable_and_bitwise;
wire [DATA_WIDTH - 1:0] o_and_bitwise;
// Interface of Bitwise OR
wire enable_or_bitwise;
wire [DATA_WIDTH - 1:0] o_or_bitwise;
// Interface of Shift block
wire enable_shift;
wire enable_shift_left;
wire enable_shift_right;
wire [DATA_WIDTH - 1:0] o_shift;
// Interface of DECODER
wire [(1<<ALU_CTRL_WIDTH) - 1:0] o_decoder;
// Interface of MUX 8to1 
wire [DATA_WIDTH - 1:0] in_mux [(1<<ALU_CTRL_WIDTH) - 1:0];

// ALU's flag
assign zero_flag = (o == {DATA_WIDTH{1'b0}});
assign overflow_flag = overflow_adder;
assign exception_flag = exception_adder;
// ADDER decode
assign enable_adder = enable_add | enable_sub;
assign invert_i_2_adder = enable_sub;	
// Shift block decode
assign enable_shift = enable_shift_left | enable_shift_right;
// Decoder block
assign enable_add = o_decoder[ADD_FUNCTION];
assign enable_sub = o_decoder[SUB_FUNCTION];
assign enable_and_bitwise = o_decoder[AND_FUNCTION];
assign enable_or_bitwise = o_decoder[OR_FUNCTION];
assign enable_shift_left = o_decoder[SLL_FUNCTION];
assign enable_shift_right = o_decoder[SRL_FUNCTION];
// MUX indexing
assign in_mux[AND_FUNCTION] = o_and_bitwise;
assign in_mux[OR_FUNCTION]  = o_or_bitwise;
assign in_mux[ADD_FUNCTION] = o_adder;
assign in_mux[3] = {DATA_WIDTH{1'b0}}; // Reserved
assign in_mux[4] = {DATA_WIDTH{1'b0}}; // Reserved
assign in_mux[5] = {DATA_WIDTH{1'b0}}; // Reserved
assign in_mux[SUB_FUNCTION] = o_adder;
assign in_mux[7] = {DATA_WIDTH{1'b0}}; // Reserved
assign in_mux[SLL_FUNCTION] = o_shift;
assign in_mux[SRL_FUNCTION] = o_shift;
assign in_mux[10] = {DATA_WIDTH{1'b0}}; // Reserved
assign in_mux[11] = {DATA_WIDTH{1'b0}}; // Reserved
assign in_mux[12] = {DATA_WIDTH{1'b0}}; // Reserved
assign in_mux[13] = {DATA_WIDTH{1'b0}}; // Reserved
assign in_mux[14] = {DATA_WIDTH{1'b0}}; // Reserved
assign in_mux[15] = {DATA_WIDTH{1'b0}}; // Reserved

// ADDER block
adder #(
  .WIDTH(DATA_WIDTH)
) adder_block (
  // Input 
  .i_1(i_1),
  .i_2(i_2),
  .invert_i_2(invert_i_2_adder),
  .enable(enable_adder),
  // Output 
  .o(o_adder),
  .overflow_flag(overflow_adder),
  .exception_flag(exception_flag),
  .zero_flag()
);

// Bitwise AND block
and_bitwise #(
  .WIDTH(DATA_WIDTH)
) and_bitwise_block (
  // Input 
  .i_1(i_1),
  .i_2(i_2),
  .enable(enable_and_bitwise),
  // Output
  .o(o_and_bitwise)
);

// Bitwise OR block
or_bitwise #(
  .WIDTH(DATA_WIDTH)
) or_bitwise_block (
  // Input
  .i_1(i_1),
  .i_2(i_2),
  .enable(enable_or_bitwise),
  // Output
  .o(o_or_bitwise)
);

shift #(
  .WIDTH(DATA_WIDTH)
) shift_block (
  // Input
  .i_1(i_1),
  .shamt(i_2[($clog2(DATA_WIDTH) - 1):0]),
  .shope(enable_shift_left), // Left/Right (1/0)
  .enable(enable_shift),
  // Output 
  .o(o_shift)
);

// Decoder
decoder #(
  .IN_WIDTH(ALU_CTRL_WIDTH),
  .ACTIVE(1'b1) // Active HIGH
) decoder_block (
  // Input
  .i(alu_ctrl),
  // Output
  .o(o_decoder)
);

multiplexer_16to1 #(
  .IN_WIDTH(DATA_WIDTH)
) mux_block (
  // Input
  .in_0(in_mux[0]),
  .in_1(in_mux[1]),
  .in_2(in_mux[2]),
  .in_3(in_mux[3]),
  .in_4(in_mux[4]),
  .in_5(in_mux[5]),
  .in_6(in_mux[6]),
  .in_7(in_mux[7]),
  .in_8(in_mux[8]),
  .in_9(in_mux[9]),
  .in_10(in_mux[10]),
  .in_11(in_mux[11]),
  .in_12(in_mux[12]),
  .in_13(in_mux[13]),
  .in_14(in_mux[14]),
  .in_15(in_mux[15]),
  .sel(alu_ctrl),
  // Output
  .out(o)
);



endmodule
