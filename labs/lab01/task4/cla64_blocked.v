module cla64_blocked(
  input  [63:0] a,
  input  [63:0] b,
  input         cin,
  output [63:0] sum,
  output        cout
);

  wire [16:0] c;
  assign c[0] = cin;
  assign cout = c[16];

  genvar i;
  generate
    for (i = 0; i < 16; i = i + 1) begin : gen_cla4
      cla4 cla_inst (
        .a(a[4*i +: 4]),
        .b(b[4*i +: 4]),
        .cin(c[i]),
        .sum(sum[4*i +: 4]),
        .cout(c[i+1])
      );
    end
  endgenerate

endmodule
