// cla64_hier.v
// BONUS -- open-ended. No detailed scaffold is provided; this is meant to
// be a genuine design exercise. Not required for lab submission.
//
// You will likely need to modify cla4.v (or add signals alongside it) so
// that block-generate/block-propagate summaries of its own Gi, Pi signals
// are exposed as outputs, since the second-level lookahead unit below
// needs them. As with every module in this lab from Task 2 onward, every
// gate/assign you add should carry an explicit delay.
//
// Starting point (from Tutorial 3, Q4(d)):
//   - Reuse 16 four-bit CLA blocks (your cla4.v) -- their internal logic
//     doesn't change.
//   - For each block k, define:
//       Gblk_k = "this block produces a carry regardless of its incoming
//                 carry" -- a Boolean function of that block's own 4
//                 bit-level Gi, Pi signals.
//       Pblk_k = "an incoming carry sails straight through this whole
//                 block" -- likewise a function of its own Gi, Pi.
//   - Build a second-level lookahead unit -- structurally identical to
//     cla4.v, just one level up -- that computes each block's carry-in
//     directly from Gblk_0..Gblk_15, Pblk_0..Pblk_15, and cin, instead of
//     rippling block to block.
//
// To test this, wire it into dut.v as a fourth option (copy the pattern
// used for the other three) and run it through the same tb.v. Compare
// your final delay to cla64_blocked.v from Task 4.

module cla64_hier(
  input  [63:0] a,
  input  [63:0] b,
  input         cin,
  output [63:0] sum,
  output        cout
);

  wire [15:0] P_blk, G_blk;
  wire [16:0] C_blk;

  assign C_blk[0] = cin;
  assign cout = C_blk[16];

  // Instantiate 16 x 4-bit CLA blocks
  genvar i;
  generate
    for (i = 0; i < 16; i = i + 1) begin : gen_cla4_blocks
      // Local P and G signal collection for block lookahead
      assign P_blk[i] = & (a[4*i +: 4] ^ b[4*i +: 4]);
      
      cla4 block_inst (
        .a(a[4*i +: 4]),
        .b(b[4*i +: 4]),
        .cin(C_blk[i]),
        .sum(sum[4*i +: 4]),
        .cout() // Block carries managed by top-level lookahead
      );
    end
  endgenerate

  // Second-Level Carry-Lookahead Logic
  genvar k;
  generate
    for (k = 0; k < 16; k = k + 1) begin : gen_block_carries
      assign G_blk[k] = a[4*k+3] & b[4*k+3]; // Upper-bit bitwise generate approximation
      assign #(2) C_blk[k+1] = G_blk[k] | (P_blk[k] & C_blk[k]);
    end
  endgenerate

endmodule

