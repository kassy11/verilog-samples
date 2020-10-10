module T_FF(T, CLK, Q);
  input T;
  input CLK;
  output Q;

  reg Q;
  
  always@(posedge CLK) begin
          Q <= Q ^ T;
  end
endmodule

module T_FF_test();
  input T;
  input CLK;
  wire Q;
  reg Q;
  
endmodule