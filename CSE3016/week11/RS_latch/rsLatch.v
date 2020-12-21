`timescale 1ns / 1ps

module rsLatch_nand (
    input R, S,
    output Q, Qc
);
    wire t1, t2;

    assign t1 =  ~(R & t2);
    assign t2 =  ~(S & t1);
    assign Q =  t1;
    assign Qc =  t2;
endmodule

module rsLatch_nor (
    input R, S,
    output Q, Qc
);
    wire t1, t2;

    assign t1 =  ~(R | t2);
    assign t2 =  ~(S | t1);
    assign Q =  t1;
    assign Qc =  t2;
endmodule
