// 4bit adder module
module ADDER(A, B, CI, S, CO);
 
    input [3:0] A;
    input [3:0] B;
    input CI;
    output [3:0] S;
    output CO;
     
    wire wire_u0_CO;
    wire wire_u1_CO;
    wire wire_u2_CO;
 
    FULL_ADDER u0(  // bit 0
        .A(A[0]),
        .B(B[0]),
        .CI(CI),
        .S(S[0]),
        .CO(wire_u0_CO)
    );
     
    FULL_ADDER u1(  // bit 1
        .A(A[1]),
        .B(B[1]),
        .CI(wire_u0_CO),
        .S(S[1]),
        .CO(wire_u1_CO)
    );
     
    FULL_ADDER u2(  // bit 2
        .A(A[2]),
        .B(B[2]),
        .CI(wire_u1_CO),
        .S(S[2]),
        .CO(wire_u2_CO)
    );
     
    FULL_ADDER u3(  // bit 3
        .A(A[3]),
        .B(B[3]),
        .CI(wire_u2_CO),
        .S(S[3]),
        .CO(CO)
    );
 
endmodule
 
// full adder module
module FULL_ADDER(A, B, CI, S, CO);
 
    input A;
    input B;
    input CI;
    output S;
    output CO;
     
    wire wire_u0_s;
    wire wire_u0_co;
    wire wire_u1_co;
 
    assign CO = wire_u0_co | wire_u1_co;
 
    half_adder u0(
        .a(A),
        .b(B),
        .s(wire_u0_s),
        .co(wire_u0_co)
    );
     
    half_adder u1(
        .a(wire_u0_s),
        .b(CI),
        .s(S),
        .co(wire_u1_co)
    );
 
endmodule
 
// half adder module
module half_adder(a, b, s, co);
 
    input a;
    input b;
    output s;
    output co;
 
    assign s = a ^ b;
    assign co = a & b;
 
endmodule

`timescale 1ns/1ns
 
module tb_ADDER();
 
    parameter CP = 20;  // global clock period
    integer i;          // control variable
     
    reg [3:0] A;        // inputs
    reg [3:0] B;
    reg CI;
    wire [3:0] S;       // outputs
    wire CO;
     
    ADDER u0(           // circuit under test
        .A(A),
        .B(B),
        .CI(CI),
        .S(S),
        .CO(CO)
    );
     
    initial begin
         
        A = 4'b0; B = 4'b0; CI =1'b0;
        for(i = 0; i <= 15; i = i + 1) begin
            #CP A = i; B = i % 4;
        end
        #CP
         
        A = 4'b0; B = 4'b0; CI =1'b1;
        for(i = 0; i <= 15; i = i + 1) begin
            #CP A = i % 8; B = i;
        end
        #CP
         
        $display("Simulation End.");
        $stop;
    end
 
endmodule

module adder_test();
  reg [3:0] a;
  reg [3:0] b;
  reg  mode;
  wire [3:0] s;
  wire co;

  ADDER_SUBTRACTOR adder(a, b, mode, s, co);

  initial begin
    a=0101; b=0001; mode=0;
    #10	a=0101; b=0101; mode=0;
    #10	$finish;
  end

  initial begin
    $monitor("a=%4b b=%4b mode=%d s=%4b co=%d", a, b, mode, s, co);
    $dumpfile("adder_test.vcd");
    $dumpvars(0, adder_test);
  end
endmodule 