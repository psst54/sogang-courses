`timescale 1ns / 1ps

module rsff_tb();
    reg R, S, CLK;
    wire Q, Qc;

    rsff tb(
        .R(R),
        .S(S),
        .CLK(CLK),
        .Q(Q),
        .Qc(Qc)
    );

    initial begin
        R = 0;
        S = 0;
        CLK = 0;
    end

     always R = #20 ~R;
     always S = #10 ~S;
     always CLK = #5 ~CLK;

     initial begin
     #80
     $finish;
     end

endmodule
