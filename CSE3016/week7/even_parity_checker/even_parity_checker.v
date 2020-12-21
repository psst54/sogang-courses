`timescale 1ns / 1ps

module evenParityChk(
    input A, B, C, D, P,
    output E
);
    
    assign E = ~(P ^ A ^ B ^ C ^ D);
endmodule