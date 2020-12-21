`timescale 1ns / 1ps

module fullAdder_tb;

    reg a, b, cin;
    wire s, cout;

    fullAdder tb (
        .a (a),
        .b (b),
        .cin (cin),
        .s (s),
        .cout (cout)
    );

    initial begin
        a = 1'b0;
        b = 1'b0;
        cin = 1'b0;
    end

    always a = #40 ~a;
    always b = #20 ~b;
    always cin = #10 ~cin;

    initial begin
        #80
        $finish;
    end

endmodule
