`timescale 1ns / 1ps

module JKFF(
    input J, K, clk, rst,
    output reg Q,
    output Q_n
    );
    assign Q_n = ~Q;
    always @ (posedge clk, negedge rst)
        if(!rst) Q <= 1'b0;
        else case({J, K})
                2'b00: Q <= Q;
                2'b01: Q <= 1'b0;
                2'b10: Q <= 1'b1;
                2'b11: Q <= ~Q;
             endcase
endmodule
