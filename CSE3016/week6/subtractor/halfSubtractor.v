`timescale 1ns / 1ps

module halfSubtractor(
    input a, b,
    output d, bout
);
    
    assign d = a ^ b;
    assign bout = ~a & b;

endmodule