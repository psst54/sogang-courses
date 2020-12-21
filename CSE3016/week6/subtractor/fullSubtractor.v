`timescale 1ns / 1ps

module fullSubtractor(
    input a, b, bin,
    output d, bout
);
    
    assign d = a ^ b ^ bin;
    assign bout = (bin & ~(a ^ b)) | ~a & b;
    
endmodule