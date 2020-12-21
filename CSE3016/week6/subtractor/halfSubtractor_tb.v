`timescale 1ns / 1ps

module halfSubtractor_tb;
    
    reg a, b;
    wire d, bout;
    
    halfSubtractor tb (
        .a (a),
        .b (b),
        .d (d),
        .bout (bout)
    );
    
    initial begin
        a = 1'b0;
        b = 1'b0;
    end
    
    always a = #20 ~a;
    always b = #10 ~b;
    
    initial begin
        #40
        $finish;
    end
    
endmodule