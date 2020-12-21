`timescale 1ns / 1ps

module evenParityChk_tb;

    reg A, B, C, D, P;
    wire E;

    evenParityChk tb (
        .A (A), .B (B), .C (C), .D (D), .P (P),
        .E (E)
    );

    initial begin
        A = 1'b0;
        B = 1'b0;
        C = 1'b0;
        D = 1'b0;
        P = 1'b0;
    end

    always A = #160 ~A;
    always B = #80 ~B;
    always C = #40 ~C;
    always D = #20 ~D;
    always P = #10 ~P;

    initial begin
        #320
        $finish;
    end

endmodule
