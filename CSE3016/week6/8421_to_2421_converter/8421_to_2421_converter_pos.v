`timescale 1ns / 1ps

module converter_pos(
    input a, b, c, d,
    output x, y, z, w
);
    
    assign x = ~(~(a | b) | ~(a | c | d));
    assign y = ~(~(a | b) | ~(a | c | ~d));
    assign z = ~(~(a | b | c) | ~(~b | d) | ~(~b | ~c));
    assign w = d;

endmodule