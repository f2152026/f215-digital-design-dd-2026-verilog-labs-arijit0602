module dut (
  input  [63:0] a,
  input  [63:0] b,
  input         cin,
  output [63:0] sum,
  output        cout
);

`ifdef CLA64_FLAT
  cla64_flat U_IMPL (.a(a), .b(b), .cin(cin), .sum(sum), .cout(cout));
`elsif CLA64_BLOCKED
  cla64_blocked U_IMPL (.a(a), .b(b), .cin(cin), .sum(sum), .cout(cout));
`else
  rca64 U_IMPL (.a(a), .b(b), .cin(cin), .sum(sum), .cout(cout));
`endif

endmodule
