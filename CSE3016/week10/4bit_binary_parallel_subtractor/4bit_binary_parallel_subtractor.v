`timescale 1ns / 1ps

module fullSubtractor(
    input a, b, b_in,
    output dif, b_out
);
    assign dif = a ^ b ^ b_in;
    assign b_out = ~a & ((b ^ b_in) | (b & b_in));
endmodule

module fourBitSubtractor(a, b, b_in, dif, b_out);
    input [3:0]a, b;
    input b_in;
    output [3:0]dif;
    output b_out;
    wire b1, b2, b3;

    fullSubtractor f0(a[0], b[0], b_in, dif[0], b1);
    fullSubtractor f1(a[1], b[1], b1, dif[1], b2);
    fullSubtractor f2(a[2], b[2], b2, dif[2], b3);
    fullSubtractor f3(a[3], b[3], b3, dif[3], b_out);
 endmodule
