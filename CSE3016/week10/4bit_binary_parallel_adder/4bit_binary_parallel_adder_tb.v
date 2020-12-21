`timescale 1ns / 1ps

module fourBitAdder_tb();
    reg [3:0] A, B;
    reg C_IN;
    wire [3:0] SUM;
    wire C_OUT;

    fourBitAdder tb(
        .a(A),
        .b(B),
        .c_in(C_IN),
        .sum(SUM),
        .c_out(C_OUT)
    );

    initial begin
        A = 0;
        B = 0;
        C_IN = 0;
    end

    always A[0] = #5 ~A[0];
    always A[1] = #10 ~A[1];
    always A[2] = #20 ~A[2];
    always A[3] = #40 ~A[3];
    always B[0] = #80 ~B[0];
    always B[1] = #160 ~B[1];
    always B[2] = #320 ~B[2];
    always B[3] = #640 ~B[3];
    always C_IN = #1280 ~C_IN;

    initial begin
	   #2560
	   $finish;
    end
endmodule
