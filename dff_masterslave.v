module dff (D,Clk,Q,Q1); //input,Clock,output
  input D,Clk;
  output Q1,Q; // Q1はmasterからの出力
  wire Qm; // masterからの出力(slaveの入力)
  assign Q1=Qm; // masterからの出力とslaveへの入力をつなぐ
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

module dff_test();
  reg d, clk;
  wire q1, q;

  dff DFF(d, clk, q, q1);

  initial begin
    clk=0; d=1;
    #10 clk=1; d=1;
    #10 clk=0; d=0;
    #10 clk=1; d=0;
    #10 clk=0; d=1;
    #10 clk=1; d=0;
    #10 clk=0; d=0;
    #10 clk=1; d=1;
  end

  initial begin
    $monitor("clk=%d, d=%d, q1=%d, q=%d", clk, d, q1, q);
    $dumpfile("dff.vcd");
    $dumpvars(0, dff_test);
  end  
endmodule

