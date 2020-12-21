`timescale 1ns / 1ps

module four_input_xor_gate_a_tb();

    reg a, b, c, d;
    wire e;

    four_input_xor_gate_a tb (
        .a (a), .b (b), .c (c), .d (d),
        .e (e)
    );

    initial begin
        a = 1'b0;
        b = 1'b0;
        c = 1'b0;
        d = 1'b0;
    end

    always a = #80 ~a;
    always b = #40 ~b;
    always c = #20 ~c;
    always d = #10 ~d;

    initial begin
        #160
        $finish;
    end

endmodule
