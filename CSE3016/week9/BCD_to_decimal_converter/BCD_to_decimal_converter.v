`timescale 1ns / 1ps

module bcdToDecimal(
    input A, B, C, D,
    output S0, S1, S2, S3, S4, S5, S6, S7, S8, S9
);

    assign S0 = A | B | C | D;
    assign S1 = A | B | C | ~D;
    assign S2 = B | ~C | D;
    assign S3 = B | ~C | ~D;
    assign S4 = ~B | C | D;
    assign S5 = ~B | C | ~D;
    assign S6 = ~B | ~C | D;
    assign S7 = ~B | ~C | ~D;
    assign S8 = ~A | D;
    assign S9 = ~A | ~D;
endmodule
