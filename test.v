module jdoodle;
    reg reset;
   reg clock;
   reg go;
   wire [1:0] state;

   // Instantiate the unit-under-test
   fsm uut (.reset(reset), .clock(clock), .go(go), .state(state));

   // Generate the clock
   initial clock <= 0;
   always #5 clock <= !clock; // 5ns half-period = 100MHz

   integer i;
   
   initial
     begin
     $display("starting");
	#100; // Wait for FPGA to come out of reset (GSR clear)
	go <= 0;
	reset <= 1; // Assert reset
	@(negedge clock); // Wait for two falling clock edges
	@(negedge clock);
	reset <= 0; // Release reset
	@(negedge clock);
	if (state !== 2'h0)
	  $display("%t: ERROR: FSM not reset!", $time);
	@(negedge clock);
	go <= 1;
	@(negedge clock);
	go <= 0;

	// Verify that  advances properly
	for (i=1; i<4; i=i+1)
	  begin
	     if (state !== i)
	       $display("%t: ERROR: FSM in state %d, expected %d!",
			$time, state, i);
	     @(negedge clock);
	  end

	// Verify that  stays zero while  is not asserted
	for (i=0; i<4; i=i+1)
	  begin
	     if (state !== 2'h0)
	       $display("%t: ERROR: FSM in state %d, expected %d!",
			$time, state, 0);
	     @(negedge clock);
	  end
	$display("Done Success!!");
	$stop; // Pasue simulation
	
     end



endmodule

module fsm (reset, clock, go, state);
   input reset;
   input clock;
   input go;
   output [1:0] state;

   reg [1:0] state;

   always @(posedge clock)
     if (reset)
       state <= 0;
     else
       case (state)
	 2'h0: state <= go ? 2'h1 : 2'h0;
	 2'h1: state <= 2'h2;
	 2'h2: state <= 2'h3;
	 2'h3: state <= 2'h0;
       endcase

endmodule