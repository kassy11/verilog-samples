module adder4bit(
        input [3:0] A,
        input [3:0] B,
        input P,
        output [3:0] S,
        output CO
        );
        
        wire [3:0] BX;
        wire U0_CO;
        wire U1_CO;
        wire U2_CO;
        
        assign BX = B ^ {4{P}};    // BX[i] = B[i] ^ P (0≦i＜4)

        FULL_ADDER U0 (.A(A[0]), .B(BX[0]), .CI(P), .S(S[0]), .CO(U0_CO));
        FULL_ADDER U1 (.A(A[1]), .B(BX[1]), .CI(U0_CO), .S(S[1]), .CO(U1_CO));
        FULL_ADDER U2 (.A(A[2]), .B(BX[2]), .CI(U1_CO), .S(S[2]), .CO(U2_CO));
        FULL_ADDER U3 (.A(A[3]), .B(BX[3]), .CI(U2_CO), .S(S[3]), .CO(CO));
endmodule

module FULL_ADDER(A, B, CI, S, CO);
  input A,B,CI;
  output S,CO;
  
  wire U1_S;
  wire U1_CO;
  wire U2_CO;
  
  HALF_ADDER U1 (.A(A), .B(B), .S(U1_S), .CO(U1_CO));
  HALF_ADDER U2 (.A(U1_S), .B(CI), .S(S), .CO(U2_CO));
  
  assign CO = U1_CO | U2_CO;
endmodule

// 半加算器
module HALF_ADDER(A,B,S,CO);
  input A, B;
  output S, CO;
  assign CO = A & B;
  assign S = (A | B) & ~CO;
endmodule


module adder_test();
  reg [3:0] a;
  reg [3:0] b;
  reg  mode;
  wire [3:0] s;
  wire co;

  adder4bit adder(a, b, mode, s, co);

  initial begin
    a=0001; b=0010; mode=0;
    #10	a=001; b=001; mode=0;
    #10	a=001; b=111; mode=0;
    #10	$finish;
  end

  initial begin
    $monitor("a=%b b=%b mode=%d s=%b co=%d", a, b, mode, s, co);
    $dumpfile("adder4bit_test.vcd");
    $dumpvars(0, adder_test);
  end
endmodule 