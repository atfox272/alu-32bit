// Name: Testbench of ALU
module alu_tb;

	localparam DATA_WIDTH = 32;
	localparam ALU_CTRL_WIDTH = 4;
	localparam ADD_FUNCTION = 4'b0010; // 2
	localparam SUB_FUNCTION = 4'b0110; // 6
	localparam AND_FUNCTION = 4'b0000; // 0
	localparam OR_FUNCTION  = 4'b0001; // 1
	localparam SLL_FUNCTION = 4'b1000; // 8
	localparam SRL_FUNCTION = 4'b1001; // 9

	reg [DATA_WIDTH - 1:0] i_1;
	reg [DATA_WIDTH - 1:0] i_2;
	reg [ALU_CTRL_WIDTH - 1:0] alu_ctrl;
	wire [DATA_WIDTH - 1:0] o;
	wire zero_flag;
	wire overflow_flag;
	wire exception_flag;

	alu #(
	  .DATA_WIDTH(DATA_WIDTH),
	  .ALU_CTRL_WIDTH(ALU_CTRL_WIDTH)
	) alu_tb (
	// Input
	  .i_1(i_1),
	  .i_2(i_2),
	  .alu_ctrl(alu_ctrl),
	// Output
	  .o(o),
	  .zero_flag(zero_flag),
	  .exception_flag(exception_flag),
	  .overflow_flag(overflow_flag)
	);
	initial begin
   	  $dumpfile("alu_tb.vcd");
   	  $dumpvars(0, alu_tb);
	end
	initial begin
 	  i_1 <= 0;
	  i_2 <= 0;
	  alu_ctrl <= AND_FUNCTION;	
	end

	reg [DATA_WIDTH - 1:0] golden_result;
	reg golden_overflow;
	reg correctness;

	initial begin
	  $display("ALU CTRL|   Input 1   |   Input 2   |    Result   |  Overflow   |  Golden Sum |  Golden Ovf | Correctness |");
	  #4;
	  i_1 <= 300;
	  i_2 <= 200;
	  alu_ctrl <= ADD_FUNCTION;
	  
	  #4;
	  i_1 <= 1324;
	  i_2 <= 203;
	  alu_ctrl <= SUB_FUNCTION;
	  
	  #4;
	  i_1 <= 32'hFFF3213;
	  i_2 <= 32'hABCD231;
	  alu_ctrl <= OR_FUNCTION;
	  
	  #4;
	  i_1 <= 32'h0001231;
	  i_2 <= 32'h1232001;
	  alu_ctrl <= AND_FUNCTION;
	  
	  #4;
	  i_1 <= 12;
	  i_2 <= 4;
	  alu_ctrl <= SLL_FUNCTION;
	  
	  #4;
	  i_1 <= 12301233;
	  i_2 <= 12;
	  alu_ctrl <= SRL_FUNCTION;
	  
	  #4;
	  i_1 <= 32'hAAAAAAAA;
	  i_2 <= 32'hBBBBBBBB;
	  alu_ctrl <= ADD_FUNCTION;
	  
	  // Add testcase here :b 
	  #4;
	  i_1 <= 300;
	  i_2 <= 200;
	  alu_ctrl <= ADD_FUNCTION;
	  
	  #4;
	  i_1 <= 300;
	  i_2 <= 200;
	  alu_ctrl <= ADD_FUNCTION;
	  
	  #4;
	  i_1 <= 300;
	  i_2 <= 200;
	  alu_ctrl <= ADD_FUNCTION;


	  #10 $finish;
	end
	
	reg[4*8 - 1:0] alu_ctrl_str;

	always @(alu_ctrl, i_1, i_2) begin
	  #1;
	  golden_result = (alu_ctrl == ADD_FUNCTION) ? i_1 + i_2 :
			  (alu_ctrl == SUB_FUNCTION) ? i_1 - i_2 :
			  (alu_ctrl == AND_FUNCTION) ? i_1 & i_2 :
			  (alu_ctrl == OR_FUNCTION)  ? i_1 | i_2 :
			  (alu_ctrl == SLL_FUNCTION) ? i_1 * (2**(i_2[$clog2(DATA_WIDTH) - 1:0])) :
			  (alu_ctrl == SRL_FUNCTION) ? i_1 / (2**(i_2[$clog2(DATA_WIDTH) - 1:0])) : 0;
	  golden_overflow = (alu_ctrl == ADD_FUNCTION) ? (golden_result < i_1) | (golden_result < i_2) : 1'b0;
	  alu_ctrl_str =  (alu_ctrl == ADD_FUNCTION) ? "ADD" :
                          (alu_ctrl == SUB_FUNCTION) ? "SUB" :
                          (alu_ctrl == AND_FUNCTION) ? "AND" :
                          (alu_ctrl == OR_FUNCTION)  ? "OR"  :
                          (alu_ctrl == SLL_FUNCTION) ? "SLL" :
                          (alu_ctrl == SRL_FUNCTION) ? "SRL" : "NC";

	  correctness = (o == golden_result) & (overflow_flag == golden_overflow);
	  $display("  %s  | %11d | %11d | %11d | %11b | %11d | %11d | %11d |", alu_ctrl_str, i_1, i_2, o, overflow_flag, golden_result, golden_overflow, correctness);
	end

endmodule
