`timescale 1ns / 1ps

module priorityEncoder(
    input A0, A1, A2, A3,
    output S0, S1
);

    assign S0 = A2 | A3;
    assign S1 = A3 | (~A0 & ~A2 & ~A3);
endmodule
