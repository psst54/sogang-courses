`timescale 1ns / 1ps

module decoder_tb();

	reg A, B;
	wire D0, D1, D2, D3;

	decoder tb (
		.A(A), .B(B),
		.D0(D0), .D1(D1), .D2(D2), .D3(D3)
	);

	initial begin
		A = 1'b0;
		B = 1'b0;
	end

	always A = #20 ~A;
	always B = #10 ~B;

	initial begin
		#40
		$finish;
	end

endmodule
