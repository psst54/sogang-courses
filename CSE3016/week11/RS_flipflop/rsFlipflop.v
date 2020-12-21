`timescale 1ns / 1ps

module rsff(
    input R, S, CLK,
    output Q, Qc
);

    reg q, qc;
    always @(posedge CLK) begin
        q <= S | (Q & ~R);
        qc <= R | (~Q & ~S);
    end
    assign Q = q;
    assign Qc = qc;
endmodule
