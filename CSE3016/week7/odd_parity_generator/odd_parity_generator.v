`timescale 1ns / 1ps

module oddParityGen(
    input A, B, C, D,
    output P
);

    assign P = ~(A ^ B ^ C ^ D);

endmodule
