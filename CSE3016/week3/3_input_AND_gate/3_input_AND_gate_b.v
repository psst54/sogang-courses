`timescale 1ns / 1ps

module three_input_and_gate_b(
    input a, b, c,
    output d, e
);
    
    assign d = a & b;
    assign e = d & c;
endmodule