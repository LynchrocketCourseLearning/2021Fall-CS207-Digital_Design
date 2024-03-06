`timescale 1ns / 1ps

module sr_74195 (
    input MR_n, CP, PE_n, J, K_n,
    input [3:0] D,
    output reg [3:0] Q,
    output Q_n
    );
    wire K;
    assign K = K_n;
    assign Q_n = ~Q[0];
    always @(posedge CP, negedge MR_n) begin
        if(!MR_n) Q <= 4'b0000;
        else begin
            if(!PE_n) Q <= D;
            else case ({J, K})
                    2'b00: {Q[3],Q[2],Q[1],Q[0]} <= {Q[2],Q[1],Q[0],Q[0]};
                    2'b01: {Q[3],Q[2],Q[1],Q[0]} <= {Q[2],Q[1],Q[0],1'b0};
                    2'b10: {Q[3],Q[2],Q[1],Q[0]} <= {Q[2],Q[1],Q[0],1'b1};
                    2'b11: {Q[3],Q[2],Q[1],Q[0]} <= {Q[2],Q[1],Q[0],~Q[0]};
            endcase
        end
    end
    
endmodule