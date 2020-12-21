`timescale 1ns / 1ps

module deMorgan_second_a(
    input a,
    input b,
    output c
    );
    
    assign c = ~(a&b);
endmodule