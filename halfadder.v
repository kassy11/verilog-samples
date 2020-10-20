module halfadder(
    input x,
    input y,
    output A,
    output cout
);
    assign cout = x & y;
    assign A = x ^ y;
endmodule // halfadder


`timescale 1ns/1ns
module halfadder_test();
    reg input1;
    reg input2;
    wire out;
    wire carryout;
    halfadder uut(
        .x(input1),
        .y(input2),
        .A(out),
        .cout(carryout)
    );
    initial begin
        input1 = 0;
        input2 = 0;
    end
    initial begin
        forever begin
            #5 input1 = $random;
        end
    end
    initial begin
        forever begin
            #5 input2 = $random;
        end
    end
    initial begin
        #100 $finish();
    end
    initial begin
        forever begin
            #5 input2 = $random;
        end
    end
    initial begin
        #100 $finish();
    end
    initial begin
        $monitor("time=%2d, IN1=%1b, IN2=%1b, CarryOut=%1b, OUT=%1b", $time, input1, input2, carryout, out);
        $dumpfile("halfadder.vcd");
        $dumpvars(0, halfadder_test);
    end
endmodule