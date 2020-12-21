`timescale 1ns / 1ps

module oddParityGen_tb;

    reg A, B, C, D;
    wire P;

    oddParityGen tb (
        .A (A), .B (B), .C (C), .D (D), 
        .P (P)
    );

    initial begin
        A = 1'b0;
        B = 1'b0;
        C = 1'b0;
        D = 1'b0;
    end

    always A = #80 ~A;
    always B = #40 ~B;
    always C = #20 ~C;
    always D = #10 ~D;

    initial begin
        #160
        $finish;
    end

endmodule
