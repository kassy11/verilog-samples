module XORTEST;
reg a, b;
wire out;

xor(out, a, b);

initial begin
    $dumpfile("XOR.vcd");
    $dumpvars(0, XORTEST);

        a = 0; b = 0;
    #10 a = 1;
    #10 a = 0; b = 1;
    #10 a = 1;
    #10 a = 0; b = 0;
    #10 $finish;
end

endmodule