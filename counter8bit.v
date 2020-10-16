/* 8-bit conter */
module counter8bit(CLK,RST,CE,Q);
    parameter COUNT = 8'd1;
    input CLK;
    input RST;
    input CE;

    output [7:0] Q;

    reg [7:0] Q;

    always@ (posedge CLK) begin
        if(RST)begin
            Q[7:0]  <= 8'd0;
        end else begin
            if(CE)begin
                Q[7:0]  <= Q[7:0] +COUNT;
            end
        end
    end
endmodule