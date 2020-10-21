
module MULTIPLIER4(
        input [3:0] A,
        input [3:0] B,
        output [7:0] Y
        );
        
        wire [3:0] AB3;
        wire [3:0] AB2;
        wire [3:0] AB1;
        wire [3:0] AB0;
        
        wire [3:0] U4_S;
        wire [3:0] U5_S;
        wire U4_CO;
        wire U5_CO;
        
        MULTIPLIER4X1 U0 (.A(A), .B(B[0]), .Y(AB0));
        MULTIPLIER4X1 U1 (.A(A), .B(B[1]), .Y(AB1));
        MULTIPLIER4X1 U2 (.A(A), .B(B[2]), .Y(AB2));
        MULTIPLIER4X1 U3 (.A(A), .B(B[3]), .Y(AB3));
        
        assign Y[0] = AB0[0];
        adder4bit U4 (.A({1'b0,  AB0[3:1]}), .B(AB1), .P(01'b0), .S(U4_S), .CO(U4_CO));
        assign Y[1] = U4_S[0];
        adder4bit U5 (.A({U4_CO, U4_S[3:1]}), .B(AB2), .P(1'b0), .S(U5_S), .CO(U5_CO));
        assign Y[2] = U5_S[0];
        adder4bit U6 (.A({U5_CO, U5_S[3:1]}), .B(AB3), .P(1'b0), .S(Y[6:3]), .CO(Y[7]));
endmodule

module MULTIPLIER4X1(
        input [3:0] A,
        input B,
        output [3:0] Y
        );
        
        assign Y = A & {4{B}};
endmodule

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

module multiplier_test();
  reg [3:0] a, b;
  wire [7:0] out;

  MULTIPLIER4 mult(a, b, out);

  initial begin
    a=1101; b=1011;
    #10 a=0001; b=1111;
  end

  initial begin
    $monitor("a=%b b=%b out=%8b", a, b, out);
    $dumpfile("mult.vcd");
    $dumpvars(0, multiplier_test);
  end
endmodule
