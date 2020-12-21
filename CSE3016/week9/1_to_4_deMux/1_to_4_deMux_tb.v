`timescale 1ns / 1ps

module demux4_tb;

	reg S0, S1, S2, S3;
	wire Y0, Y1, Y2, Y3, Y4, Y5, Y6, Y7, Y8, Y9, Y10, Y11, Y12, Y13, Y14, Y15;

	demux4 tb (
	.S0 (S0), .S1 (S1), .S2 (S2), .S3 (S3),
	.Y0 (Y0), .Y1 (Y1), .Y2 (Y2), .Y3 (Y3),
	.Y4 (Y4), .Y5 (Y5), .Y6 (Y6), .Y7 (Y7),
	.Y8 (Y8), .Y9 (Y9), .Y10 (Y10), .Y11 (Y11),
	.Y12 (Y12), .Y13 (Y13), .Y14 (Y14), .Y15 (Y15)
	);

	initial begin
		S0 = 1'b0;
		S1 = 1'b0;
		S2 = 1'b0;
		S3 = 1'b0;
	end

	always S0 = #80 ~S0;
	always S1 = #40 ~S1;
	always S2 = #20 ~S2;
	always S3 = #10 ~S3;

	initial begin
		#160
		$finish;
	end

endmodule
