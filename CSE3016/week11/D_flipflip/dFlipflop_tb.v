`timescale 1ns / 1ps

module dff_tb();
    reg D, CLK;
    wire Q, Qc;
    
    dff tb(
        .D(D),
        .CLK(CLK),
        .Q(Q),
        .Qc(Qc)
    );
    initial begin
        D = 0;
        CLK = 0;
    end

    always D = #10 ~D;
    always CLK = #5 ~CLK;

    initial begin
        #40
        $finish;
    end

endmodule
