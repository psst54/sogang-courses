`timescale 1ns / 1ps

module deMorgan_second_b(
    input a,
    input b,
    output c
    );
    
    assign c = (~a)|(~b);
endmodule