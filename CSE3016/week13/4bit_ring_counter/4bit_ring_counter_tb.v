`timescale 1ns / 1ps

module ringCounter_tb();
    reg CLK, RST;
    wire [3:0] Q;

    ringCounter tb(
        .clk(CLK),
        .rst(RST),
        .q(Q)
    );

    initial begin
        CLK = 0;
        RST = 1;
        #10 RST = 0;
    end

    always CLK = #5 ~CLK;

    initial begin
        #200
        $finish;
    end
endmodule
