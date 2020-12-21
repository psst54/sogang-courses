`timescale 1ns / 1ps

module deMorgan_first_b(
    input a, b,
    output c
);
    
    assign c = ~a & ~b;
endmodule