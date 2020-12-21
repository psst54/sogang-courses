`timescale 1ns / 1ps

module demux(
    input D, a, b,
    output z0, z1, z2, z3
);
    assign z0 = ~a & ~b & D;
    assign z1 = ~a & b & D;
    assign z2 = a & ~b & D;
    assign z3 = a & b & D;
endmodule

module demux4(
	input S0, S1, S2, S3,
	output Y0, Y1, Y2, Y3, Y4, Y5, Y6, Y7, Y8, Y9, Y10, Y11, Y12, Y13, Y14, Y15
);

	wire t;
	wire demux_0, demux_1, demux_2, demux_3;

    assign t = 1;
    demux entry(t, S0, S1, demux_0, demux_1, demux_2, demux_3);

    demux f0(demux_0, S2, S3, Y0, Y1, Y2, Y3);
    demux f1(demux_1, S2, S3, Y4, Y5, Y6, Y7);
    demux f2(demux_2, S2, S3, Y8, Y9, Y10, Y11);
    demux f3(demux_3, S2, S3, Y12, Y13, Y14, Y15);
endmodule
