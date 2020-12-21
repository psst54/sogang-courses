`timescale 1ns / 1ps

module counter(
    input clk, rst,
    output wire [3:0] q
);

    wire [3:0] tmp;
    wire [3:0] qc;

    dff f0(~rst & (~q[0]), clk, tmp[0], qc[0]);
    dff f1(~rst & ((~q[1] & q[0]) | (q[1] & ~q[0])), clk, tmp[1], qc[1]);
    dff f2(~rst & ((q[2] & ~q[1]) | (q[2] & ~q[0]) | (~q[2] & q[1] & q[0])), clk, tmp[2], qc[2]);
    dff f3(~rst & ((q[3] & ~q[2]) | (q[3] & ~q[1]) | (q[3] & ~q[0]) | (~q[3] & q[2] & q[1] & q[0])), clk, tmp[3], qc[3]);

    assign q = tmp;
endmodule

module dff(
    input D, CLK,
    output reg Q, Qc
);

    always @(posedge CLK) begin
        Q <= D;
        Qc <= ~D;
    end
endmodule
