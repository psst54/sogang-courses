`timescale 1ns / 1ps

module fullAdder(
    input a, b, c_in,
    output sum, c_out
);
    assign sum = a ^ b ^ c_in;
    assign c_out = (a ^ b) & c_in | (a & b);
endmodule


module bcdAdder(a, b, c_in, sum, c_out);
    input [3:0]a, b;
    input c_in;
    output [3:0]sum;
    output c_out;

    wire [3:0]tmp_sum;
    wire c1, c2, c3, c4, c5, c6, tmp_out, out;

    fullAdder f0(a[0], b[0], c_in, tmp_sum[0], c1);
    fullAdder f1(a[1], b[1], c1, tmp_sum[1], c2);
    fullAdder f2(a[2], b[2], c2, tmp_sum[2], c3);
    fullAdder f3(a[3], b[3], c3, tmp_sum[3], tmp_out);

    assign c_out = tmp_out | (tmp_sum[3] & tmp_sum[2]) | (tmp_sum[3] & tmp_sum[1]);

    fullAdder f4(tmp_sum[0], 0, 0, sum[0], c4);
    fullAdder f5(tmp_sum[1], c_out, c4, sum[1], c5);
    fullAdder f6(tmp_sum[2], c_out, c5, sum[2], c6);
    fullAdder f7(tmp_sum[3], 0, c6, sum[3], out);

 endmodule
