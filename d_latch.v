// Dラッチの実装

module d_latch(EN, D, Q);
  input EN, D;
  output Q;
  reg Q;

  /// EN or Dが変化した時
  always @(EN or D)
    // ENが１ならQにDを設定する
    if (EN)
      Q <= D;
endmodule

module d_latch_test();
  reg en, d;
  wire q;

  d_latch DLATCH(en, d, q);

  initial begin
    $monitor("EN=%d, D=%d, Q=%d", en, d, q);
    $dumpfile("d_latch_test.vcd");
    $dumpvars(0, d_latch_test);
  end

  initial begin
    en=0; d=1;
    #10 en=1; d=0;
    #10 en=0; d=0;
    #10 en=1; d=1;
  end

endmodule