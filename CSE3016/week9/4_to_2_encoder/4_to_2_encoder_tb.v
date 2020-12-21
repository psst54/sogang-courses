`timescale 1ns / 1ps

module encoder_tb;

	reg A, B, C, D;
	wire E0, E1;

	encoder tb (
		.A (A), .B (B), .C (C), .D (D),
		.E0 (E0), .E1 (E1)
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
		#160
		$finish;
	end

endmodule
