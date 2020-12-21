`timescale 1ns / 1ps

module fourBitSubtractor_tb();
    reg [3:0] A, B;
    reg B_IN;
    wire [3:0] DIF;
    wire B_OUT;

    fourBitSubtractor tb(
        .a(A),
        .b(B),
        .b_in(B_IN),
        .dif(DIF),
        .b_out(B_OUT)
    );

    initial begin
        A = 0;
        B = 0;
        B_IN = 0;
    end

    always A[0] = #5 ~A[0];
    always A[1] = #10 ~A[1];
    always A[2] = #20 ~A[2];
    always A[3] = #40 ~A[3];
    always B[0] = #80 ~B[0];
    always B[1] = #160 ~B[1];
    always B[2] = #320 ~B[2];
    always B[3] = #640 ~B[3];
    always B_IN = #1280 ~B_IN;

    initial begin
	   #2560
	   $finish;
    end
endmodule
