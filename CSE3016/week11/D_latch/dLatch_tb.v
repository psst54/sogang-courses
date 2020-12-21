`timescale 1ns / 1ps

module dLatch_tb();
    reg D, E;

    dLatch tb(
        .D(D),
        .E(E),
        .Q(Q),
        .Qc(Qc)
    );

    initial begin
        D = 0;
        E = 0;
    end

    always E = #20 ~E;
    always D = #5 ~D;

    initial begin
        #80
        $finish;
    end

endmodule
