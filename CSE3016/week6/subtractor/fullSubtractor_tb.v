`timescale 1ns / 1ps

module fullSubtractor_tb;
    
    reg a, b, bin;
    wire d, bout;
    
    fullSubtractor tb (
        .a (a),
        .b (b),
        .bin (bin),
        .d (d),
        .bout (bout)
    );
    
    initial begin
        a = 1'b0;
        b = 1'b0;
        bin = 1'b0;
    end
    
    always a = #40 ~a;
    always b = #20 ~b;
    always bin = #10 ~bin;
    
    initial begin
        #80
        $finish;
    end
    
endmodule