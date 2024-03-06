`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////


module change(
input clk,[9:0] n,
output reg[7:0]s1, reg[7:0]s2, reg[7:0]s3
    );
parameter zero = 8'b11000000; //0
parameter one = 8'b11111001;  //1
parameter two = 8'b10100100;  //2
parameter three = 8'b10110000;//3
parameter four = 8'b10011001; //4     //124678
parameter five = 8'b10010010; //5
parameter six = 8'b10000010;  //6
parameter seven = 8'b11111000;//7
parameter eight = 8'b10000000;//8
parameter nine = 8'b10010000; //9
always@(posedge clk)begin
    case(n/100)
         0: s1<=zero;
         1: s1<=one;
         2: s1<=two;
         3: s1<=three;
         4: s1<=four;
         5: s1<=five;
         6: s1<=six;
         7: s1<=seven;
         8: s1<=eight;
         9: s1<=nine;
    endcase
    case((n-(n/100)*100)/10)
         0: s2<=zero;
         1: s2<=one;
         2: s2<=two;
         3: s2<=three;
         4: s2<=four;
         5: s2<=five;
         6: s2<=six;
         7: s2<=seven;
         8: s2<=eight;
         9: s2<=nine;
    endcase
    case(n-(n/100)*100-((n-(n/100)*100)/10)*10)
         0: s3<=zero;
         1: s3<=one;
         2: s3<=two;
         3: s3<=three;
         4: s3<=four;
         5: s3<=five;
         6: s3<=six;
         7: s3<=seven;
         8: s3<=eight;
         9: s3<=nine;
        endcase
end
        
endmodule
