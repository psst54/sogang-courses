`timescale 1ns / 1ps

module deMorgan_first_a(
    input a, b,
    output c
);
    
    assign c = ~(a | b);
endmodule