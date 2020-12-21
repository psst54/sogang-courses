`timescale 1ns / 1ps

module priorityEncoder_tb;

	reg A0, A1, A2, A3;
	wire S0, S1;

	priorityEncoder tb (
		.A0 (A0), .A1 (A1), .A2 (A2), .A3 (A3),
		.S0 (S0), .S1 (S1)
	);

	initial begin
		A0 = 1'b0;
		A1 = 1'b0;
		A2 = 1'b0;
		A3 = 1'b0;
	end

	always A0 = #80 ~A0;
	always A1 = #40 ~A1;
	always A2 = #20 ~A2;
	always A3 = #10 ~A3;

	initial begin
		#160
		$finish;
	end

endmodule
