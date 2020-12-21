`timescale 1ns / 1ps

module shiftRegister(
    input clk, in,
    output wire [3:0] q
);

    wire [3:0] tmp, qc;

    dff f0(in, clk, tmp[0], qc[0]);
    dff f1(tmp[0], clk, tmp[1], qc[1]);
    dff f2(tmp[1], clk, tmp[2], qc[2]);
    dff f3(tmp[2], clk, tmp[3], qc[3]);

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
