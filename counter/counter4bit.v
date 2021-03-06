module counter4bit(sysclk,reset, Q1,Q2,Q3,Q4);
   input sysclk;
   input reset;
   output wire Q1;
   output wire Q2;
   output wire Q3;
   output wire Q4;

    T_FF  num_1(1'b1, sysclk, reset, Q1);
    T_FF  num_2(1'b1, Q1, reset, Q2);
    T_FF  num_3(1'b1, Q2, reset, Q3); 
    T_FF  num_4(1'b1, Q3, reset, Q4);
 endmodule

 module T_FF(T, CLK, RST, Q);
    input T;
    input CLK;
    input RST;
    output Q;
    reg Q;
    
    // RST=0のときリセット
    always@(posedge CLK) begin
            Q <= RST ? Q ^ T: 0;
    end
endmodule

module counter4bit_test();
  reg sysclk, reset;
  wire q1, q2, q3, q4;

  counter4bit COUNTER(sysclk, reset, q1, q2, q3, q4);

  initial begin
    sysclk=1; reset
  end

  initial begin
    $monitor("data=%b, LED=%b", data, led);
    $dumpfile("counter4bit.vcd");
    $dumpvars(0, counter4bit_test);
  end
endmodule
