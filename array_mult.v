// http://www.icsd2.tj.chiba-u.jp/~kitakami/lab-2013/ans3.htm

module array_mult();

  adder8bit ADDER0();
  adder8bit ADDER1();
  adder8bit ADDER2();
endmodule

module adder8bit(A, B, MODE, S, CO);
  input [7:0] A;
  input [7:0] B;
  input MODE; // mode=0のとき加算
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

  assign BX = B ^ {8{MODE}};   // 1の補数を求める

  // 8bitなので全加算器８個接続
  FULL_ADDER U0 (.A(A[0]), .B(BX[0]), .CI(MODE), .S(S[0]), .CO(U0_CO));
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
    
    $monitor("a=%8b b=%8b mode=%d s=%b co=%d", a, b, mode, s, co);
    $dumpfile("adder_test.vcd");
    $dumpvars(0, adder_test);
  end
endmodule 

