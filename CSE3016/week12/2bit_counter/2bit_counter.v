`timescale 1ns / 1ps

module counter(
    input clk,
    output wire [1:0] q
);
    wire [1:0] tmp;
    wire [1:0] qc;

    jkff f0(1'b1, 1'b1, clk, tmp[0], qc[0]);
    jkff f1(q[0], q[0], clk, tmp[1], qc[1]);

    assign q = tmp;
endmodule

module jkff(
    input J, K, CLK,
    output reg Q, Qc
);

    initial begin
        Q = 0;
        Qc = 1;
    end

    always @(posedge CLK) begin
        Q <= J & (~Q) | (~K) & Q;
        Qc <= ~(J & (~Q) | (~K) & Q);
    end
endmodule
