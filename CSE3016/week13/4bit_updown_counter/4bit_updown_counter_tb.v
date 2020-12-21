`timescale 1ns / 1ps

module counter_tb();
    reg CLK, UP;
    wire [3:0] Q;

    counter tb(
        .clk(CLK),
        .up(UP),
        .q(Q)
    );

    initial begin
        CLK = 0;
        UP = 0;
        #50 UP = 1;
        #120 UP = 0;
    end

    always CLK = #5 ~CLK;

    initial begin
        #300
        $finish;
    end

endmodule
