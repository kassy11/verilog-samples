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

module master_slave_dff();
  d_latch MASTER();
  d_latch SLAVE();

endmodule