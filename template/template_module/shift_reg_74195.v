`timescale 1ns / 1ps

module shift_reg_74195(
input MR_n,CP,PE_n,J,K_n,
input D3,D2,D1,D0,
output reg Q3,Q2,Q1,Q0
    );
    wire K;
    assign K = ~K_n;
    always @(posedge CP,negedge MR_n)
        if(!MR_n)
            {Q3,Q2,Q1,Q0}<=4'b0000;
        else
            if(!PE_n)
                {Q3,Q2,Q1,Q0} <= {D3,D2,D1,D0};
            else
                case ({J,K})
                    2'b00:{Q3,Q2,Q1,Q0}<={Q2,Q1,Q0,Q0};
                    2'b01:{Q3,Q2,Q1,Q0}<={Q2,Q1,Q0,1'b0};
                    2'b10:{Q3,Q2,Q1,Q0}<={Q2,Q1,Q0,1'b1};
                    2'b11:{Q3,Q2,Q1,Q0}<={Q2,Q1,Q0,~Q0};
                endcase
                 
endmodule
