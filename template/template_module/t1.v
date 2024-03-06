`timescale 1ns / 1ps

module t1(
    input x, clk,
    output A, B
    );
    JKFF jka(.J(~x), .K(B), .clk(clk),.rst(1'b1));
    JKFF jkb(.J(x), .K(~A), .clk(clk),.rst(1'b1));
endmodule
