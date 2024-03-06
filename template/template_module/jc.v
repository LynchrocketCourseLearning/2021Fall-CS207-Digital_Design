`timescale 1ns / 1ps

module jc (
    input clk,
    input rst_n,
    input en_n,
    input [3:0] in,
    output reg [3:0] out
    );
    reg J = 1'b1, K_n = 1;b1;
    sr_74195 sr(.CP(clk),.MR_n(rst_n),.PE_n(en_n),.J(J),.K_n(K_n),.D(in),.Q(out));
    always @ (posedge clk, negedge rst_n) begin
        if(~rst_n) out <= 4'b0;
        else begin
            if(rst_n and en_n) begin
                if(out[3]) {J,K_n} = 2'b00;
                else {J,K_n} = 2'b11;
            end
        end
    end
endmodule