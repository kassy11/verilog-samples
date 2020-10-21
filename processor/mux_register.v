module mux_register(clk, rst0, rst1, rst2, rst3, en0, en1, en2, en3, OUT, Sel, In0, In1, In2, In3, D); 
  input [7:0]  In0,In1,In2,In3; // registerからの入力
  input [7:0] D;
  input [4:0] Sel; 
  output [7:0] Out; 
  reg [7:0] Out = 0; 
  input [7:0] Out_in;
  input clk;
  input en0, en1, en2, en3;
  input rst0, rst1, rst2, rst3;

  assign Out_in = Out;

  register8bit REG0(clk, rst0, en0, Out_in, Out);
  register8bit REG1(clk, rst1, en1, Out_in, Out);
  register8bit REG2(clk, rst2, en2, Out_in, Out);
  register8bit REG3(clk, rst3, en3, Out_in, Out);
  mux5to1 MUX(Out_in, Sel, In0, In1, In2, In3);
endmodule


module register8bit(clk, rst, en, reg_in, reg_out);
	input 		clk;
	input 		rst;
  input     en;
	input	[7:0] reg_in;
	output	[7:0] reg_out;
	reg	[7:0] reg_out;
	
	always @(posedge clk or negedge rst) begin
		if(rst == 1'b0) begin // resetする
      reg_out	<= 8'b00000000;
    end
		else if(en == 1) begin // enableのときだけ取り込み
			reg_out	<= reg_in;      
    end
	end	
endmodule


module mux5to1(OUT, Sel, In0, In1, In2, In3, D); 
  input [7:0]  In0,In1,In2,In3 D;
  input [2:0] Sel; 
  output [7:0] Out; 
  reg [7:0] Out; 

  always @ (In0 or In1 or In2 or In3 or D or Sel) begin 
  case (Sel) 
    3'b000 : Out = In0; 
    3'b001 : Out = In1; 
    3'b010 : Out = In2; 
    3'b011 : Out = In3; 
    default : Out = 8'bx; 
  endcase 
  end  
endmodule