// 2:1マルチプレクサの簡易実装

module mux_lbit_2to1(X, Y, S, Q);
  input X, Y, S;
  output Q;
  assign Q=(~S & X) | (S & Y);
endmodule

module mux2to1_test();
  reg X;
  reg Y;
  reg S;
  wire Q;
  mux_lbit_2to1 i0(X, Y, S, Q);

  initial begin
    X=1; Y=0; S=0;
    #10	X=1; Y=0; S=1;
    #10	$finish;
  end

  initial begin
    $monitor("X=%d, Y=%d, Switch=%d, LED=%d", X, Y, S, Q);
    $dumpfile("dump.vcd");
    $dumpvars(0, mux2to1_test);
  end
endmodule