module cnt_bit (CK, RES, EN, Q, CU);
   input   CK, RES, EN;
   output Q, CU;
   reg      Q;


   always @(posedge CK or posedge RES) begin
         if (RES)
         Q <= 1'b0;
         else if (EN)
         Q <= ~Q;
   end


   assign CU = EN & Q;


endmodule


module counter_hex (clk, res, q);
   input           clk, res;
   output [3:0] q;
   wire    [3:0] cu;
   cnt_bit cb0 (clk, res, 1'b1,  q[0], cu[0]);
   cnt_bit cb1 (clk, res, cu[0], q[1], cu[1]);
   cnt_bit cb2 (clk, res, cu[1], q[2], cu[2]);
   cnt_bit cb3 (clk, res, cu[2], q[3], cu[3]);
endmodule

