module dff (D,Clk,Q,Q1); //input,Clock,output
input D,Clk;
output Q1,Q;
wire Qm;
assign Q1=Qm;
d_latch d1(D,~Clk,Qm); //master
d_latch d2(Qm,Clk,Q); //slave
endmodule

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
