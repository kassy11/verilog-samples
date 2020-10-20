module register8bit(clk, rst, en, reg_in, reg_out);
	input 		clk;
	input 		rst;
  input     en;
	input	[7:0] reg_in;
	output	[7:0] reg_out;
	reg	[7:0] reg_out;
	
	always @(posedge clk or negedge rst) begin
		if(rst == 1'b0)
			reg_out	<= 8'b00000000;
		else if(en == 1)
			reg_out	<= reg_in;
	end
	
endmodule

module register8bit_test();


endmodule