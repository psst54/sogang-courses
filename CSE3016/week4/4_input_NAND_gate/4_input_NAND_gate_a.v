`timescale 1ns / 1ps

module four_input_nand_gate_a(
    input a, b, c, d,
    output e
);
    
    assign e = ~(a & b & c & d);
endmodule