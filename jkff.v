module jkff (J, K, CLK, Q, QB);
	input J, K, CLK;
	output Q, QB;
	reg Q;	
	
	assign QB = ~Q;	
	
	always@(posedge CLK) begin	
		if(J==1) begin
			if(K==1) begin
				Q <= ~Q;	// J=K=1のときは反転
			end else begin // J=1, K=0のときセット
				Q <= 1;		
			end
		end else begin
			if(K==1) begin
				Q <= 0;		// J=0, K=1のときはリセット
			end
		end
	end
endmodule

module jkff_test();
  reg j, k, clk;
  wire q, qb;

  jkff JKFF(j, k, clk, q, qb);

  initial begin
    $monitor("J=%d, K=%d, CLK=%d, Q=%d, QB=%d", j, k, clk, q, qb);
    $dumpfile("jkff_test.vcd");
    $dumpvars(0, jkff_test);
  end

  initial begin
    j=0; k=1; clk=1; 
    #10 clk=0;
    #10 j=1; k=0; clk=1;
    #10 clk=0;
    #10 j=0; k=0; clk=1;
    #10 clk=0;
    #10 j=1; k=0; clk=1;
    #10 clk=0;
    #10 j=0; k=1; clk=1;
    #10 clk=0;
    #10 $finish;
  end
endmodule