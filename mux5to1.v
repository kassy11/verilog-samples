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

module mux5to1_led(sw, led);
  input [5:0] sw;
  output led;
  wire w;

  mux_lbit_2to1 MUX(sw[2], sw[1], sw[0], w);
  control_led LED(w, led);
endmodule
module mux5to1_test();

endmodule