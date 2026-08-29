// FA_Gate.v
// Gate-level model of a 1-bit full adder. No delays yet -- that starts in
// Task 2. This task is purely about gate ordering.
//
// Part (a): leave this file exactly as it is, compile, and simulate.
// Part (b): AFTER completing part (a), come back and reorder the five gate
//           instantiations below into any different sequence, then
//           re-simulate with the same tb.v and compare.

module FA_Gate(
  input  a,
  input  b,
  input  cin,
  output sum,
  output cout
);

  wire w1, w2, w3;

  xor #(2) g1(w1, a, b);
  xor #(2) g2(sum, w1, cin);

  and #(2) g3(w2, a, b);
  and #(2) g4(w3, w1, cin);
  or  #(2) g5(cout, w2, w3);

endmodule

