`timescale 1ns/1ns


module top;
   reg    clk, res;
   wire [3:0] q;


   parameter STEP = 100;
   always #(STEP/2) clk = ~clk;


   counter_hex counter_hex_i (clk, res, q);


   initial begin
   #0    res = 0; clk = 0;
   #STEP res = 1;
   #STEP res = 0;
   #(STEP*20)
            $finish;
end

   initial begin
      $dumpfile ("counter.vcd");      //GTKwaveで波形表示する為の記述
      $dumpvars(0, top);      //GTKwaveで波形表示する為の記述
      $monitor ($stime, "res=%b clk=%b Q=%h",res, clk, q);
   end


endmodule
