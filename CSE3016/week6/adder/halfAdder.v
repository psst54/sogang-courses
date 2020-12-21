`timescale 1ns / 1ps

module halfAdder(
    input a, b,
    output s, cout
);
    
    assign s = a ^ b;
    assign cout = a & b;

endmodule