// 2:1マルチプレクサ
// LEDモジュールを利用

module control_led(switch, led);
  input switch;
  output led;
  assign led=switch;
endmodule

module mux_lbit_2to1(X, Y, S, Q);
  input X, Y, S;
  output Q;
  assign Q=(~S & X) | (S & Y);
endmodule

module mux2to1_led(sw, led);
  input [2:0] sw;
  output led;
  wire w;

  mux_lbit_2to1 MUX(sw[2], sw[1], sw[0], w);
  control_led LED(w, led);
endmodule

module mux2to1_test();
  reg [2:0] sw;
  wire led;

  mux2to1_led MUX(sw, led);

  initial begin
    sw[0]=1; sw[1]=1; sw[2]=0;
    #10	sw[0]=0; sw[1]=1; sw[2]=0;
    #10	$finish;
  end

  initial begin
    $monitor("X=%d, Y=%d, Switch=%d, LED=%d", sw[1], sw[2], sw[0], led);
    $dumpfile("mux2to1_test.vcd");
    $dumpvars(0, mux2to1_test);
  end
endmodule