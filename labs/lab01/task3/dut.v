module dut (
  input  [3:0] a,
  input  [3:0] b,
  input        cin,
  output [3:0] sum,
  output       cout
);

`ifdef CLA4
  cla4 U_IMPL (.a(a), .b(b), .cin(cin), .sum(sum), .cout(cout));
`elsif CLA4_DATAFLOW
  cla4_dataflow U_IMPL (.a(a), .b(b), .cin(cin), .sum(sum), .cout(cout));
`else
  rca U_IMPL (.a(a), .b(b), .cin(cin), .sum(sum), .cout(cout));
`endif

endmodule