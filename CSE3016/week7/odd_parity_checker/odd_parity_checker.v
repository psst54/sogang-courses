`timescale 1ns / 1ps

module oddParityChk(
    input A, B, C, D, P,
    output E
);
    
    assign E = P ^ A ^ B ^ C ^ D;

endmodule