module PC(
    input CLK,
    input RST,
    output [31:0] INST
    );

    wire write = 1'b0; // dont write..
    wire [31:0] data_in = 32'b0;
    wire [31:0] data_out;

    assign INST = data_out;
    wire [4:0] addr;

    // call program counter
    COUNTER5B COUNTER(
        .CLK(CLK), .addr(addr), .RST(RST)
    );
    // call program memory   
    CPU_REG PMEM(
        .addr(addr), .data_in(data_in), .data_out(data_out), .write(write));      

endmodule

module CPU_REG(
    input [4:0] addr, //32-words MIPS like
    input [31:0] data_in,
    output [31:0] data_out,

    input CLK,
    input write
    );

    reg [31:0] PROGRAM[31:0];

    initial $readmemb("バイナリファイルの置き場所", PROGRAM);

    assign data_out = PROGRAM[addr];
    always @(posedge CLK) if(write) PROGRAM[addr] <= data_in;

endmodule


module COUNTER5B(
    input CLK,
    input RST,
    output [4:0] addr);

    // 2^5 (32-state) counter
    reg [4:0] count; 
    assign addr = count;

    always @(posedge CLK) begin
        if(RST == 1) begin
            count = 5'b0;
        end
        else begin
            count = count + 1;
        end
    end

endmodule

module GPR(
    input CLK,
    input [4:0] REGNUM0, REGNUM1, REGNUM2,
    input [31:0] DIN0,
    input WE0,
    output [31:0] DOUT0, DOUT1
  );

    reg [31:0] r[15:0];

    assign DOUT0 = (REGNUM0==0) ? 0 : r[REGNUM0];
    assign DOUT1 = (REGNUM1==0) ? 0 : r[REGNUM1];
    always @(posedge CLK) if (WE0) r[REGNUM2] <= DIN0;

endmodule

module ALU(
    input [5:0] opcode,
    input [31:0] ina,
    input [31:0] inb,
    input ALUsrc,
    input [5:0] funct,
    input [31:0] INST,

    output [31:0] out, ALUA, ALUB,
    output flag

    );

    // 直値を使うかレジスタ値を使うかALUsrcによってswitch
    always @(*) begin
        if(ALUsrc) begin
            ALUB2 = imm_i;
            end
        else begin
            ALUB2 = inb;
        end
    end

    assign flag = tout[32]; //Overflow Flag
    assign out = tout[31:0];    

    // ALU function
    always@(*) begin
        if(opcode==6'd0) begin
            case(funct)
                6'd0: // add
                tout = ALUA + ALUB;
                6'd2: // sub
                tout = ALUA - ALUB;
                6'd10: // XOR
                tout = ALUA ^ ALUB;
                default:
                tout = ALUA + ALUB;
            endcase
        end
        else begin //直値の場合
                tout = ALUA + ALUB;
        end
    end
endmodule

module tb_mips_v2();
// CLK
reg clk;
reg RST;

// REG
reg write;

// for INST
//reg [31:0] INST;
wire [31:0] INST;

// monitor
wire flag;
wire [31:0] out, reg_out, ina, inb, ALUA, ALUB;
wire [31:0] DOUT0;
wire [4:0] addr;

// top circuit
top_module_mips_v2 t0(
    .CLK(clk), .write(write), .flag(flag), .out(out),
    .ina(ina), .inb(inb),.ALUA(ALUA),.ALUB(ALUB), .INST(INST), .addr(addr), .RST(RST)
);

initial begin
    clk <= 1'b0;
    write <= 1'b1;
    RST <= 1'b1;
end


always #5 begin
    clk <= ~clk;
end

task wait_posedge_clk;
    input   n;
    integer n;

    begin
        for(n=n; n>0; n=n-1) begin
            @(posedge clk)
                ;
        end
    end
endtask

initial begin

    wait_posedge_clk(2);
    RST <= 1'b0;

    wait_posedge_clk(50);

    $finish;
end


endmodule