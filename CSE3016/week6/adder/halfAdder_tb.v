`timescale 1ns / 1ps

module halfAdder_tb;
    
    reg a, b;
    wire s, cout;
    
    halfAdder tb (
        .a (a),
        .b (b),
        .s (s),
        .cout (cout)
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