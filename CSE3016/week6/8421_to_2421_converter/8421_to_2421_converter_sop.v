`timescale 1ns / 1ps

module converter_sop(
    input a, b, c, d,
    output x, y, z, w
);
    
    assign x = ~(~a & ~(b & c) & ~(b & d));
    assign y = ~(~a & ~(b & c) & ~(b & ~d));
    assign z = ~(~a & ~(~b & c) & ~(b & ~c & d));
    assign w = d;

endmodule