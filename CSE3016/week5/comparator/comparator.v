`timescale 1ns / 1ps

module comparator(
    input a, b,
    output equal, not_equal, a_greater, b_greater
);
    
    assign equal = ~((~a & b) | (a & ~b));
    assign not_equal = ((~a & b) | (a & ~b));
    assign a_greater = a & ~b;
    assign b_greater = ~a & b;
endmodule