module mux5to1(Out, Sel, In1, In2, In3, In4, In5); 
  input [2:0]  In1,In2,In3,In4,In5;
  input [2:0] Sel; 
  output [2:0] Out; 
  reg [2:0] Out; 

  always @ (In1 or In2 or In3 or In4 or In5 or Sel) begin 
  case (Sel) 
    3'b000 : Out = In1; 
    3'b001 : Out = In2; 
    3'b010 : Out = In3; 
    3'b011 : Out = In4; 
    3'b100 : Out = In5; 
    default : Out = 3'bx; 
  endcase 
  end  
endmodule

module mux5to1_test();
  reg [2:0] sel;
  reg [2:0]  In1,In2,In3,In4,In5;
  wire [2:0] Out;

  mux5to1 MUX(Out, sel, In1, In2, In3, In4, In5);

  initial begin
    sel=3'b000; In1=111; In2=110; In3=110; In4=110; In5=110;
    #10 sel=3'b001; In1=110; In2=111; In3=110; In4=110; In5=110;
    #10 sel=3'b010; In1=110; In2=110; In3=111; In4=110; In5=110;
    #10 sel=3'b011; In1=110; In2=110; In3=110; In4=111; In5=110;
    #10 sel=3'b100; In1=110; In2=110; In3=110; In4=110; In5=111;
  end

  initial begin
    $monitor("sel=%b, Out=%b, In1=%b, In2=%b, In3=%b, In4=%b, In5=%b"
              ,sel, Out, In1, In2, In3, In4, In5);
    $dumpfile("mux5to1_test.vcd");
    $dumpvars(0, mux5to1_test);
  end
endmodule

