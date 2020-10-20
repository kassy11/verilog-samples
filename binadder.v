module add_sub_v
    (
        SUB_ADD,
        IN_A,
        IN_B,
        RESULT,
        UNDER_OVER
    );

    input    SUB_ADD;
    input    [7:0] IN_A, IN_B;
    output    [7:0] RESULT;
    output    UNDER_OVER;
   
    // Wire Declaration
    wire [7:0] w_IN_B;
    wire carry_out;

    /* Concurrent Assignment */
   
    assign w_IN_B[7] = SUB_ADD ^ IN_B[7];
    assign w_IN_B[6] = SUB_ADD ^ IN_B[6];
    assign w_IN_B[5] = SUB_ADD ^ IN_B[5];
    assign w_IN_B[4] = SUB_ADD ^ IN_B[4];
    assign w_IN_B[3] = SUB_ADD ^ IN_B[3];
    assign w_IN_B[2] = SUB_ADD ^ IN_B[2];
    assign w_IN_B[1] = SUB_ADD ^ IN_B[1];
    assign w_IN_B[0] = SUB_ADD ^ IN_B[0];
   
    bin_adder_v bin_adder_v_inst
    (
        .CARRY_IN(SUB_ADD),
        .IN_A(IN_A),
        .IN_B(w_IN_B),
        .SUM_OUT(RESULT),
        .CARRY_OUT(carry_out)
    );

    assign UNDER_OVER = SUB_ADD ^ carry_out;

endmodule

module bin_adder_v
    (
        CARRY_IN,
        IN_A,
        IN_B,
        SUM_OUT,
        CARRY_OUT
    );

    input    CARRY_IN;
    input    [7:0] IN_A, IN_B;
    output    [7:0] SUM_OUT;
    output    CARRY_OUT;
   
    assign {CARRY_OUT, SUM_OUT}
    = {1'b0,IN_A} + {1'b0,IN_B} + {8'b00000000, CARRY_IN};

endmodule