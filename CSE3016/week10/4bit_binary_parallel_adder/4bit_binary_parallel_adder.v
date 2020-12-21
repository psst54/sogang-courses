`timescale 1ns / 1ps

module fullAdder(
    input a, b, c_in,
    output sum, c_out
);
    assign sum = a ^ b ^ c_in;
    assign c_out = (a & b)  |  (a & c_in)  |  (b & c_in);
endmodule

module fourBitAdder(a, b, c_in, sum, c_out);
    input [3:0]a, b;
    input c_in;
    output [3:0]sum;
    output c_out;
    wire c1, c2, c3;

    fullAdder f0(a[0], b[0], c_in, sum[0], c1);
    fullAdder f1(a[1], b[1], c1, sum[1], c2);
    fullAdder f2(a[2], b[2], c2, sum[2], c3);
    fullAdder f3(a[3], b[3], c3, sum[3], c_out);
endmodule
