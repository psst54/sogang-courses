`timescale 1ns / 1ps

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
