`timescale 1ns / 1ps

module counter_tb();
    reg CLK, RST;
    wire [3:0] Q;

    counter tb(
        .clk(CLK),
        .rst(RST),
        .q(Q)
    );

    initial begin
        CLK = 0;
        RST = 1;
        RST = #10 0;
    end

    always CLK = #5 ~CLK;

    initial begin
        #300
        $finish;
    end

endmodule
