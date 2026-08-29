module cla4(
  input  [3:0] a,
  input  [3:0] b,
  input        cin,
  output [3:0] sum,
  output       cout
);

  wire [3:0] p, g;
  wire [4:0] c;

  assign c[0] = cin;
  assign cout = c[4];

  xor #(2) (p[0], a[0], b[0]);
  xor #(2) (p[1], a[1], b[1]);
  xor #(2) (p[2], a[2], b[2]);
  xor #(2) (p[3], a[3], b[3]);

  and #(2) (g[0], a[0], b[0]);
  and #(2) (g[1], a[1], b[1]);
  and #(2) (g[2], a[2], b[2]);
  and #(2) (g[3], a[3], b[3]);

  wire p0c0, p1g0, p1p0c0, p2g1, p2p1g0, p2p1p0c0;
  wire p3g2, p3p2g1, p3p2p1g0, p3p2p1p0c0;

  and #(2) (p0c0, p[0], c[0]);
  or  #(2) (c[1], g[0], p0c0);

  and #(2) (p1g0, p[1], g[0]);
  and #(2) (p1p0c0, p[1], p[0], c[0]);
  or  #(2) (c[2], g[1], p1g0, p1p0c0);

  and #(2) (p2g1, p[2], g[1]);
  and #(2) (p2p1g0, p[2], p[1], g[0]);
  and #(2) (p2p1p0c0, p[2], p[1], p[0], c[0]);
  or  #(2) (c[3], g[2], p2g1, p2p1g0, p2p1p0c0);

  and #(2) (p3g2, p[3], g[2]);
  and #(2) (p3p2g1, p[3], p[2], g[1]);
  and #(2) (p3p2p1g0, p[3], p[2], p[1], g[0]);
  and #(2) (p3p2p1p0c0, p[3], p[2], p[1], p[0], c[0]);
  or  #(2) (c[4], g[3], p3g2, p3p2g1, p3p2p1g0, p3p2p1p0c0);

  xor #(2) (sum[0], p[0], c[0]);
  xor #(2) (sum[1], p[1], c[1]);
  xor #(2) (sum[2], p[2], c[2]);
  xor #(2) (sum[3], p[3], c[3]);

endmodule
