module T_FF(T, CLK, Q);
  input T;
  input CLK;
  output Q;

  reg Q;
  
  always@(posedge CLK) begin
          Q <= Q ^ T;
  end
endmodule

module counter4bit();
  T_FF TFF1();


endmodule