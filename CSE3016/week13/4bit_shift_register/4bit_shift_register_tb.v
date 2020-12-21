`timescale 1ns / 1ps

module shiftRegister_tb();
    reg CLK, IN;
    wire [3:0] Q;

    shiftRegister tb(
        .clk(CLK),
        .in(IN),
        .q(Q)
    );

    initial begin
        CLK = 0;
        IN = 1;
        #15 IN = 0;
        #25 IN = 1;
    end

    always CLK = #5 ~CLK;

    initial begin
        #200
        $finish;
    end
endmodule
