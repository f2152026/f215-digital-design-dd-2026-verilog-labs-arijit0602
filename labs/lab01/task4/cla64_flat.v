// cla64_flat.v
// A flat, unblocked 64-bit carry-lookahead adder: every carry is computed
// directly (two-level, no rippling), exactly like cla4.v, just scaled to
// 64 bits. Add delays throughout (same convention as cla4.v) so it can be
// fairly compared against rca64.v and cla64_blocked.v.

module cla64_flat(
  input  [63:0] a,
  input  [63:0] b,
  input         cin,
  output [63:0] sum,
  output        cout
);

  wire [63:0] p, g;
  wire [64:1] c;

  genvar i;
  generate
    for (i = 0; i < 64; i = i + 1) begin : gen_pg
      xor #(2) (p[i], a[i], b[i]);
      and #(2) (g[i], a[i], b[i]);
    end
  endgenerate

  function calc_carry;
    input integer k;
    input [63:0] p_in;
    input [63:0] g_in;
    input cin_in;
    integer m, l;
    reg term_or;
    reg term_and;
    begin
      term_or = 1'b0;
      for (m = 0; m <= k - 2; m = m + 1) begin
        term_and = g_in[m];
        for (l = m + 1; l <= k - 1; l = l + 1) begin
          term_and = term_and & p_in[l];
        end
        term_or = term_or | term_and;
      end
      
      term_and = cin_in;
      for (l = 0; l <= k - 1; l = l + 1) begin
        term_and = term_and & p_in[l];
      end
      
      calc_carry = g_in[k-1] | term_or | term_and;
    end
  endfunction

  genvar k;
  generate
    for (k = 1; k <= 64; k = k + 1) begin : carry_gen
      assign #(2) c[k] = calc_carry(k, p, g, cin);
    end
  endgenerate

  assign cout = c[64];
  assign #(2) sum = p ^ {c[63:1], cin};

endmodule