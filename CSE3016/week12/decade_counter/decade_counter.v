`timescale 1ns / 1ps

module counter(
    input clk,
    output wire [3:0] q
);

    wire [3:0] tmp, qc;

    jkff f0(1'b1, 1'b1, clk, tmp[0], qc[0]);
    jkff f1(~q[3] & q[0], q[1] & q[0], clk, tmp[1], qc[1]);
    jkff f2(q[1] & q[0], q[1] & q[0], clk, tmp[2], qc[2]);
    jkff f3(q[2] & q[1] & q[0], q[3] & q[0], clk, tmp[3], qc[3]);

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
