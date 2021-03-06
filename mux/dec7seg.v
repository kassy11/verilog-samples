module dec7seg(data, LED);
input [3:0] data;
output [6:0] LED;

wire [3:0] data; 
reg [6:0] LED; 

always @(data) begin
  case (data)
    4'd0: LED = 7'b1110111;
    4'd1: LED = 7'b1111100;
    4'd2: LED = 7'b0111001;
    4'd3: LED = 7'b1011110;
    4'd4: LED = 7'b1111001;
    4'd5: LED = 7'b1110001;
    default: LED = 7'b0000000;
	endcase
end
endmodule


module dec7seg_test;
  reg [3:0] data;
  wire [6:0] led;

  dec7seg i0(data, led);

  initial begin
    data = 4'd0;
    #10	data = 4'd1;
    #10	data = 4'd2;
    #10	data = 4'd3;
    #10	data = 4'd4;
    #10	data = 4'd5;
    #10	data = 4'd6;
    #10	data = 4'd7;
    #10	data = 4'd8;
    #10	data = 4'd9;
    #10	data = 4'd10;
    #10	data = 4'd11;
    #10	data = 4'd12;
    #10	data = 4'd13;
    #10	data = 4'd14;
    #10	data = 4'd15;
    #10	$finish;
  end

  initial begin
    $monitor("data=%b, LED=%b", data, led);
    $dumpfile("dec7seg_test.vcd");
    $dumpvars(0, dec7seg_test);
  end
endmodule