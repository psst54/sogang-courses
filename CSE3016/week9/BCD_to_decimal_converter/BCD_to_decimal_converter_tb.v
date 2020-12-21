`timescale 1ns / 1ps

module bcdToDecimal_tb;

	reg A, B, C, D;
	wire S0, S1, S2, S3, S4, S5, S6, S7, S8, S9;

	bcdToDecimal tb (
		.A (A), .B (B), .C (C), .D (D),
		.S0 (S0), .S1 (S1), .S2 (S2), .S3 (S3), .S4 (S4),
		.S5 (S5), .S6 (S6), .S7 (S7), .S8 (S8), .S9 (S9)
	);

	initial begin
		A = 1'b0;
		B = 1'b0;
		C = 1'b0;
		D = 1'b0;
	end

	always A = #80 ~A;
	always B = #40 ~B;
	always C = #20 ~C;
	always D = #10 ~D;

	initial begin
		#100
		$finish;
	end

endmodule
