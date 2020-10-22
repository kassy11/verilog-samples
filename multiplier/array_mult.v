// http://www.icsd2.tj.chiba-u.jp/~kitakami/lab-2013/ans3.htm

module MULTIPLIER8(
        input [7:0] A,
        input [7:0] B,
        output [15:0] Y
        );
        
        wire [7:0] AB3;
        wire [7:0] AB2;
        wire [7:0] AB1;
        wire [7:0] AB0;
        
        wire [7:0] U4_S;
        wire [7:0] U5_S;
        wire U4_CO;
        wire U5_CO;
        
        MULTIPLIER8X1 U0 (.A(A), .B(B[0]), .Y(AB0));
        MULTIPLIER8X1 U1 (.A(A), .B(B[1]), .Y(AB1));
        MULTIPLIER8X1 U2 (.A(A), .B(B[2]), .Y(AB2));
        MULTIPLIER8X1 U3 (.A(A), .B(B[3]), .Y(AB3));
        
        assign Y[0] = AB0[0];
        adder8bit U4 (.A({1'b0,  AB0[7:1]}), .B(AB1), .P(01'b0), .S(U4_S), .CO(U4_CO));
        assign Y[1] = U4_S[0];
        adder8bit U5 (.A({U4_CO, U4_S[7:1]}), .B(AB2), .P(1'b0), .S(U5_S), .CO(U5_CO));
        assign Y[2] = U5_S[0];
        adder8bit U6 (.A({U5_CO, U5_S[7:1]}), .B(AB3), .P(1'b0), .S(Y[14:7]), .CO(Y[15]));
endmodule

module MULTIPLIER8X1(
        input [7:0] A,
        input B,
        output [7:0] Y
        );
        
        assign Y = A & {8{B}};
endmodule

module adder8bit(A, B, P, S, CO);
  input [7:0] A;
  input [7:0] B;
  input P; // mode=0のとき加算
  output [7:0] S;
  output CO;

  wire [7:0] BX;
  wire U0_CO;
  wire U1_CO;
  wire U2_CO;
  wire U3_CO;
  wire U4_CO;
  wire U5_CO;
  wire U6_CO;

  assign BX = B ^ {8{P}};   // 1の補数を求める

  // 8bitなので全加算器８個接続
  FULL_ADDER U0 (.A(A[0]), .B(BX[0]), .CI(P), .S(S[0]), .CO(U0_CO));
  FULL_ADDER U1 (.A(A[1]), .B(BX[1]), .CI(U0_CO), .S(S[1]), .CO(U1_CO));
  FULL_ADDER U2 (.A(A[2]), .B(BX[2]), .CI(U1_CO), .S(S[2]), .CO(U2_CO));
  FULL_ADDER U3 (.A(A[3]), .B(BX[3]), .CI(U2_CO), .S(S[3]), .CO(U3_CO));
  FULL_ADDER U4 (.A(A[4]), .B(BX[4]), .CI(U3_CO), .S(S[4]), .CO(U4_CO));
  FULL_ADDER U5 (.A(A[5]), .B(BX[5]), .CI(U4_CO), .S(S[5]), .CO(U5_CO));
  FULL_ADDER U6 (.A(A[6]), .B(BX[6]), .CI(U5_CO), .S(S[6]), .CO(U6_CO));
  FULL_ADDER U7 (.A(A[7]), .B(BX[7]), .CI(U6_CO), .S(S[7]), .CO(CO));
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
  reg [7:0] a;
  reg [7:0] b;
  reg  mode;
  wire [7:0] s;
  wire co;

  adder8bit adder(a, b, mode, s, co);

  initial begin
    a=00000001; b=00000001; mode=0;
    #10	a=01010101; b=00101110; mode=0;
    #10	a=01010101; b=00101110; mode=1;
    #10	a=01010101; b=10101110; mode=0;
    #10	a=01010101; b=10101110; mode=1;
    #10	a=01010101; b=11010101; mode=1;
    #10	$finish;
  end

  initial begin
    
    $monitor("a=%b b=%b mode=%d s=%b co=%d", a, b, mode, s, co);
    $dumpfile("adder_test.vcd");
    $dumpvars(0, adder_test);
  end
endmodule 

