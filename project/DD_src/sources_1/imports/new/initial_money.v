`timescale 1ns / 1ps

module initial_money(
    input clk,rst,sw,next,[3:0] n,   //next进入下一步
    output reg [3:0]money,
    output reg[63:0]show
    );
parameter start=3'b000;
parameter set= 3'b001;  //设置数额
parameter check= 3'b010; //核对
parameter ok=3'b011; //成功
parameter fail=3'b100; //失败
parameter show0=-1; 
reg swt;
reg rstt;
reg nextt;
reg[7:0]show1;
reg[7:0]show2;
reg[7:0]show3;
reg [1:0]state;
reg [1:0]next_state;
reg[3:0]n1;
reg[3:0]n2;
reg[3:0]n3;
reg[9:0]sum;
integer num;
integer n1t;
integer n2t;
integer n3t;
reg [7:0]show1t;
reg [7:0]show2t;
reg [7:0]show3t;

turn t(.clk(clk),.rst(rstt),.sw(swt),.next(nextt),.n(n),.n1(n1t),.n2(n2t),.n3(n3t),.show1(show1t),.show2(show2t),.show3(show3t));

parameter zero = 8'b11000000; //0
parameter one = 8'b11111001;  //1
parameter two = 8'b10100100;  //2
parameter three = 8'b10110000;//3
parameter four = 8'b10011001; //4
parameter five = 8'b10010010; //5
parameter six = 8'b10000010;  //6
parameter seven = 8'b11111000;//7
parameter eight = 8'b10000000;//8
parameter nine = 8'b10010000; //9
parameter _A = 8'b10001000;   //A
parameter _B = 8'b10000011;   //b
parameter _C = 8'b11000110;   //C
parameter _D = 8'b10100001;   //d
parameter _E = 8'b10000110;   //E
parameter _F = 8'b10001110;   //F
parameter _G = 8'b11000010;   //G
parameter _H = 8'b10001001;   //H
parameter _I = 8'b11110000;   //I
parameter _J = 8'b11110001;   //J
parameter _K = 8'b10001010;   //K
parameter _L = 8'b11000111;   //L
parameter _M = 8'b11001000;   //M
parameter _N = 8'b10101011;   //n
parameter _O = 8'b10100011;   //o
parameter _P = 8'b10001100;   //P
parameter _Q = 8'b10011000;   //Q
parameter _R = 8'b11001110;   //r
parameter _S = 8'b10110110;   //S
parameter _T = 8'b10000111;   //T
parameter _U = 8'b11000001;   //U
parameter _V = 8'b11100011;   
parameter _W = 8'b10000001;   //W
parameter _X = 8'b10011011;   //X
parameter _Y = 8'b10010001;   //y
parameter _Z = 8'b10100101;   //z
always@(posedge clk,posedge rst,posedge next) begin//重置
    if(rst)begin
        state<=start;
        end
    else if(next&&sw)
        state<=next_state;
end


            
       


always@(num,state)if(sw)begin
    begin
        if(state==start)begin
            n1=show0;
            n2=show0;
            n3=show0;
        end       
    end
    if(n1==show0)
        n1=num;
    else if(n2==show0)
        n2=num;
    else if(n3==show0)
        n3=num;
end


begin  
    if(sw)begin
        case(state)
            start:
                nextstate=set;
            set:
                nextstate=check;
            check:begin
                if(sum<10)
                    nextstate=ok;
                else
                    nextstate=fail;
            end
            ok:begin
                money=sum;
                nextstate=start;
            end 
            fail:
                nextstate=start;                             
         endcase       
    end
end


always@(show1,show2,show3,state)if(sw)begin
    case(state)
        start:
            show={one,56'b11111111_11111111_11111111_11111111_11111111_11111111_11111111};
        set:
            show={one,32'b11111111_11111111_11111111_11111111,show1,show2,show3};
        ok:
            show={one,16'b11111111_11111111,_E,_R,_R,_O,_R};
        fail:
            show={one,_S,_U,_C,_C,_E,_S,_S};
    endcase
end

endmodule
