`timescale 1ns / 1ps

module dLatch (
    input D, E,
    output reg Q, Qc
);

    always @(E or D) begin
        if (E) begin
            Q = D;
            Qc = ~D;
        end
        else begin
            Q = Q;
            Qc = Qc;
        end
    end
endmodule
