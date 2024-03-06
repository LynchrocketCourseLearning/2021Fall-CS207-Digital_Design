`timescale 1ns / 1ps
//转换器，将开发板小键盘输入的数转过来
module turn(
input clk,rst,sw,[0:0]next,
input [3:0]n,  //输入的一位整数
output [9:0] num, //显示的三位数
output integer n1,integer n2,integer n3, //百位，十位，个位
output reg[7:0] show1,reg[7:0]show2,reg[7:0]show3
    );
reg [2:0]state,next_state;//
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
parameter none=8'b11110111;
parameter start=3'b000;
parameter bai=3'b000;
parameter shi=3'b010;
parameter ge=3'b011;
reg [0:0]o;
reg flag1;
reg flag2;
reg e;
always@(posedge clk)
 if(n==12)e=1'b1;
 else e=1'b0;
wire [0:0]flag_out;
assign flag_out = (!flag2) && flag1;
always@(posedge clk,posedge rst)begin
	if(rst==1)begin
		flag1 <= 1'b0;
		flag2 <= 1'b0;
	end
	else begin
		flag1 <= e;
		flag2 <= flag1 ;
	end
end
always@(posedge clk)
    if(rst)begin   //初始化
        state<=bai;
    end
    else
    if(flag_out&&sw)
              state<=next_state;
    






always@(posedge clk)
    
    if(sw)
    case(state)
       
        bai:
            next_state<=shi;
        shi:
            next_state<=ge;
        ge:
            next_state<=bai;
        
    endcase
assign
 num=100*n1+10*n2+n3;
    
always@(posedge clk,posedge rst)
        if(rst)
        begin 
       
                n1<=0;
                n2<=0;
                n3<=0;
        
        end
        else if(sw)begin
        case(state)
                    bai:if(n<=9)n1<=n;
                    shi:if(n<=9)n2<=n;
                    ge:if(n<=9)n3<=n;
                  
                    
                endcase
       
        end       



always@(posedge clk,posedge rst)
    if(rst)
    begin    
        
        show1<=none;
        show2<=none;
        show3<=none;
    end
    else if(sw)
    begin

   
        case(n1)
            0: show1<=zero;
            1: show1<=one;
            2: show1<=two;
            3: show1<=three;
            4: show1<=four;
            5: show1<=five;
            6: show1<=six;
            7: show1<=seven;
            8: show1<=eight;
            9: show1<=nine;
        endcase
        
       
        case(n2)
            0: show2<=zero;
            1: show2<=one;
            2: show2<=two;
            3: show2<=three;
            4: show2<=four;
            5: show2<=five;
            6: show2<=six;
            7: show2<=seven;
            8: show2<=eight;
            9: show2<=nine;
        endcase
        
       
        case(n3)
            0: show3<=zero;
            1: show3<=one;
            2: show3<=two;
            3: show3<=three;
            4: show3<=four;
            5: show3<=five;
            6: show3<=six;
            7: show3<=seven;
            8: show3<=eight;
            9: show3<=nine;
               endcase
    end  
   
endmodule
