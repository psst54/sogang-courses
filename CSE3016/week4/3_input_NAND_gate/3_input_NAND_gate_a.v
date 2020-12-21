`timescale 1ns / 1ps

module three_input_nand_gate_a(
    input a, b, c,
    output d
);
    
    assign d = ~(a & b & c);
endmodule