`timescale 1ns / 1ps

module deMorgan_first_b_tb;

    reg a, b;
    wire c;

    deMorgan_first_b tb (
        .a (a), .b (b),
        .c (c)
    );

    initial begin
        a = 1'b0;
        b = 1'b0;
    end

    always a = #20 ~a;
    always b = #10 ~b;

    initial begin
        #40
        $finish;
    end

endmodule
