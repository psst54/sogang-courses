`timescale 1ns / 1ps

module booleanFunction_second_a(
    input a, b, c,
    output d
);
    
    assign d = (~a & ~b) | ~c;
endmodule