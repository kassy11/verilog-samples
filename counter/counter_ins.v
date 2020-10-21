module binary_counter (Clock , Q);
  input Clock ;
  output [ 3: 0] Q;
  wire [ 3: 0] Q;
  reg [ 3 : 0 ] Count ;
  
  assign Q = Count ;
  always @(posedge Clock )
  begin
    Count <= Count + 1 ’ b1 ;
  end
endmodule