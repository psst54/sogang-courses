`timescale 1ns / 1ps

module rsLatch_tb();
    reg R, S;
    wire Q, Qc;

    rsLatch_nand tb( // rsLatch_nor
        .R(R),
        .S(S),
        .Q(Q),
        .Qc(Qc)
    );

     initial begin
         R = 0;
         S = 0;
     end

     always R = #20 ~R;
     always S = #10 ~S;

     initial begin
        #80
        $finish;
     end

endmodule
