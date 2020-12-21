`timescale 1ns / 1ps

module counter_tb();
    reg CLK;
    wire [1:0] Q;

    counter tb(
        .clk(CLK),
        .q(Q)
    );

    initial CLK = 0;

    always CLK = #5 ~CLK;

    initial begin
        #200
        $finish;
    end
endmodule
