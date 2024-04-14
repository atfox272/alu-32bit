// Name: Full Adder
module full_adder (
  input i_1, // Input 1
  input i_2, // Input 2
  input i_3, // Input 3 (previous carry)
  output s,  // Sum
  output c   // Carry
);

wire s_ha1; 
wire c_ha1;
wire c_ha2;

assign c = c_ha1 | c_ha2;

half_adder ha1 (
  .i_1(i_1),
  .i_2(i_2),
  .s(s_ha1),
  .c(c_ha1)
);

half_adder ha2 (
  .i_1(i_3),
  .i_2(s_ha1),
  .s(s),
  .c(c_ha2)
);

endmodule

