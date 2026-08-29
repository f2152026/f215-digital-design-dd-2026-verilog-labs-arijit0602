`timescale 1ns/1ps

module tb;
  reg  [3:0] a, b;
  reg        cin;
  wire [3:0] sum;
  wire       cout;

  dut U_DUT (
    .a(a),
    .b(b),
    .cin(cin),
    .sum(sum),
    .cout(cout)
  );

  initial begin
    $dumpfile("waves.vcd");
    $dumpvars(0, tb);

    a = 4'b0000; b = 4'b0000; cin = 1'b0;
    #20;
    a = 4'b0101; b = 4'b0011; cin = 1'b1;
    #20;
    a = 4'b0111; b = 4'b0001; cin = 1'b0;
    #20;
    a = 4'b1010; b = 4'b0101; cin = 1'b0;
    #20;
    $finish;
  end

  initial begin
    $monitor("%t a=%b b=%b cin=%b | sum=%b cout=%b", $time, a, b, cin, sum, cout);
  end
endmodule
