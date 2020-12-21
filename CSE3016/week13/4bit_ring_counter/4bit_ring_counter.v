`timescale 1ns / 1ps

module ringCounter(
    input clk, rst,
    output wire [3:0] q
);

    wire [3:0] tmp, qc;

    dff f0(rst | q[0], clk, tmp[3], qc[3]);
    dff f1(~rst & q[3], clk, tmp[2], qc[2]);
    dff f2(~rst & q[2], clk, tmp[1], qc[1]);
    dff f3(~rst & q[1], clk, tmp[0], qc[0]);

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
