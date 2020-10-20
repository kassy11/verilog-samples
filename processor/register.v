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

module register8bit_test();
  reg [7:0] reg_in;
  reg clk;
  reg rst;
  reg en;
  wire [7:0] reg_out;

  register8bit REG(clk, rst, en, reg_in, reg_out);

  initial begin
    reg_in = 00010101;
    clk = 1; en = 1; rst = 1;
    #10 clk = 0;
    #10	$finish;
  end

  initial begin
    $monitor("reg_in=%d, reg_out=%d, clk=%d, rst=%d, en=%d ", reg_in, reg_out, clk, rst, en);
    $dumpfile("register8bit_test.vcd");
    $dumpvars(0, register8bit_test);
  end

endmodule