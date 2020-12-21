`timescale 1ns / 1ps

module comparator_tb;

    reg a, b;
    wire equal, not_equal, a_greater, b_greater;

    comparator tb (
        .a (a), .b (b),
        .equal (equal),
        .not_equal (not_equal),
        .a_greater (a_greater),
        .b_greater (b_greater)
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
