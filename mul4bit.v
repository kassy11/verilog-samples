module Multiplier_4bit(output [8:0] y, input [3:0] i1, input [3:0] i2);
  assign y=i1*i2;
endmodule

module multiplier_test();
  reg [3:0] a, b;
  wire [8:0] out;

  Multiplier_4bit mult(out, a, b);

  initial begin
    a=1101; b=1011;
    #10 a=0001; b=1111;
  end

  initial begin
    $monitor("a=%b b=%b out=%b", a, b, out);
    $dumpfile("mult.vcd");
    $dumpvars(0, multiplier_test);
  end
endmodule
