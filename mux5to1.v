module mux5to1(OUT, Sel, In1, In2, In3, In4, In5); 
  input [7:0]  In1,In2,In3,In4,In5,In6,In7,In8;
  input [2:0] Sel; 
  output [7:0] Out; 
  reg [7:0] Out; 

  always @ (In1 or In2 or In3 or In4 or In5 or Sel) begin 
  case (Sel) 
    3'b000 : Out = In1; 
    3'b001 : Out = In2; 
    3'b010 : Out = In3; 
    3'b011 : Out = In4; 
    3'b100 : Out = In5; 
    default : Out = 8'bx; 
  endcase 
  end  
endmodule

module mux5to1_test();
  reg [2:0] sel;
  wire led;

   mux5to1 MUX(sel)

  initial begin
    sw[0]=1; sw[1]=1; sw[2]=0;
    #10	sw[0]=0; sw[1]=1; sw[2]=0;
    #10	$finish;
  end

  initial begin
    $monitor("X=%d, Y=%d, Switch=%d, LED=%d", sw[1], sw[2], sw[0], led);
    $dumpfile("mux5to1_test.vcd");
    $dumpvars(0, mux5to1_test);
  end
endmodule