module JKFF (J, K, CLK, Q, QB);
	input J, K, CLK;
	output Q, QB;
	reg Q;	
	
	assign QB = ~Q;	
	
	always@(posedge CLK) begin	
		if(J==1) begin
			if(K==1) begin
				Q <= ~Q;	
			end else begin
				Q <= 1;		
			end
		end else begin
			if(K==1) begin
				Q <= 0;		
			end
		end
	end
endmodule

`timescale 10ps / 10ps

module TESTBENCH;
	reg J, K, CLK;
	wire Q, QB;
	
	JKFF CUT(.J(J), .K(K), .CLK(CLK), .Q(Q), .QB(QB));
	
	initial begin
		$dumpfile("JKFF.vcd");
		$dumpvars(1, TESTBENCH);
		
		CLK <= 0;
		J <= 0; K <= 0; #10 CLK <= 1; #50 CLK <= 0; #40 // 保持
		J <= 1; K <= 0; #10 CLK <= 1; #50 CLK <= 0; #40 // セット
		J <= 0; K <= 0; #10 CLK <= 1; #50 CLK <= 0; #40 // 保持
		J <= 0; K <= 1; #10 CLK <= 1; #50 CLK <= 0; #40 // リセット	
		J <= 0; K <= 0; #10 CLK <= 1; #50 CLK <= 0; #40 // 保持
		J <= 1; K <= 1; #10 CLK <= 1; #50 CLK <= 0; #50 // 反転
                                    CLK <= 1; #50 CLK <= 0; #50 // 反転
                                    CLK <= 1; #50 CLK <= 0; #50 // 反転
                    /* 通常、JK値と クロックは同時に変化させない */
		$finish;
	end
endmodule