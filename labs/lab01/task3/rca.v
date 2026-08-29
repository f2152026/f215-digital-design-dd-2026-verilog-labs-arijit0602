module rca (
  input  [3:0] a,
  input  [3:0] b,
  input        cin,
  output [3:0] sum,
  output       cout
);

  wire [4:0] c;
  assign c[0] = cin;
  assign cout = c[4];

  genvar i;
  generate
    for (i = 0; i < 4; i = i + 1) begin : gen_fa
      FA_Gate fa_inst (
        .a(a[i]),
        .b(b[i]),
        .cin(c[i]),
        .sum(sum[i]),
        .cout(c[i+1])
      );
    end
  endgenerate

endmodule
