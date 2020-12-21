`timescale 1ns / 1ps

module jkff_tb();
    reg J, K, CLK;
    wire Q, Qc;

    jkff m(
        .J(J),
        .K(K),
        .CLK(CLK),
        .Q(Q),
        .Qc(Qc)
    );

    initial begin
        J = 0;
        K = 0;
        CLK = 0;
    end

    always J = #20 ~J;
    always K = #10 ~K;
    always CLK = #5 ~CLK;

    initial begin
        #80
        $finish;
    end

endmodule
