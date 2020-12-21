`timescale 1ns / 1ps

module four_input_aoi_gate(
    input a, b, c, d,
    output e, f, g
);
    
    assign e = a & b;
    assign f = c & d;
    assign g = ~(e | f);
endmodule