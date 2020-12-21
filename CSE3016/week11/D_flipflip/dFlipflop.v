`timescale 1ns / 1ps

module dff(
    input D, CLK,
    output reg Q, Qc
);

    always @(posedge CLK) begin
        Q <= D;
        Qc <= ~D;
    end
endmodule
