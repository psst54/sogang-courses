`timescale 1ns / 1ps

module mux(
    input A, B, C, D, E, F, G, H,
    input S0, S1, S2,
    output Y
);
    wire t0, t1, t2, t3, t4, t5, t6, t7;

    assign t0 = ~S0 & ~S1 & ~S2;
    assign t1 = ~S0 &~S1 & S2;
    assign t2 = ~S0 & S1 & ~S2;
    assign t3 = ~S0 & S1 & S2;
    assign t4 = S0 & ~S1 & ~S2;
    assign t5 = S0 & ~S1 & S2;
    assign t6 = S0 & S1 & ~S2;
    assign t7 = S0 & S1 & S2;
    assign Y = (t0 & A) | (t1 & B) | (t2 & C) | (t3 & D) | (t4 & E) | (t5 & F) | (t6 & G) | (t7 & H);
endmodule
