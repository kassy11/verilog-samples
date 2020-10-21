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

module T_FF_test();
  reg trigger;
  reg clock;
  reg reset;
  wire q;

  T_FF TFF(trigger, clock, reset, q);

  initial begin
    $monitor("T=%d, CLK=%d, RST=%d, Q=%d", trigger, clock, reset, q);
    $dumpfile("T_FF_test.vcd");
    $dumpvars(0, T_FF_test);
  end
  
  initial begin
    clock=1; trigger=1; reset=0; // q=0
    #10 clock=0;
    #10	clock=1; trigger=1; reset=1;
    #10 clock=0;
    #10	clock=1; trigger=1; 
    #10 clock=0;
    #10	clock=1; trigger=1; 
    #10 clock=0;
    #10 $finish;
  end
endmodule

