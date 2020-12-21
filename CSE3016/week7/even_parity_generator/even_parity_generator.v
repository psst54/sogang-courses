`timescale 1ns / 1ps

module evenParityGen(
    input A, B, C, D,
    output P
);
    
    assign P = A ^ B ^ C ^ D;

endmodule