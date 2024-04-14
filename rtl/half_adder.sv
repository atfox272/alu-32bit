// Name: Half adder
module half_adder (
  input i_1, // Input 1
  input i_2, // Input 2
  output s,  // Sum
  output c   // Carry
);

assign s = i_1 ^ i_2;
assign c = i_1 & i_2;

endmodule 
