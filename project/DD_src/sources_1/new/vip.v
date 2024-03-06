`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2022/01/05 01:45:01
// Design Name: 
// Module Name: vip
// Project Name: 
// Target Devices: 
// Tool Versions: 
// Description: 
// 
// Dependencies: 
// 
// Revision:
// Revision 0.01 - File Created
// Additional Comments:
// 
//////////////////////////////////////////////////////////////////////////////////


module vip(input clk,rst,rstk,sw,[0:0]next,[3:0]n,[2:0]mode,[0:0]nextt,
output reg[63:0]show
    );
  reg nextti;
  parameter spw=4'b0000;  //输入 密码
  parameter ok=4'b0001; //成功
  parameter fail=4'b0010;//失败
  parameter sm=4'b0011; //输入 金额
  parameter s1=4'b0100; //1 
  parameter s2=4'b0101; //1 
  parameter s3=4'b0110; //1 
  parameter s4=4'b0111; //1 
  parameter zero = 8'b11000000; //0
  parameter one = 8'b11111001;  //1
  parameter two = 8'b10100100;  //2
  parameter three = 8'b10110000;//
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
  parameter _Z = 8'b10100101; 
  //z
  
  reg [3:0]state;
  reg [3:0]next_state;
  wire integer num;
  wire n1t;
  wire n2t;
  wire n3t;
  wire [7:0]show1t;
  wire [7:0]show2t;
  wire [7:0]show3t;
reg flag1;
  reg flag2;
  wire [0:0]flag_out;
  reg [2:0]idnum;
  reg [3:0]s1p1;
  reg [3:0]s1p2;
   reg [3:0]s1p3;
    reg [3:0]s2p1;
    reg [3:0]s2p2;
     reg [3:0]s2p3;
   reg [3:0]s3p1;
      reg [3:0]s3p2;
       reg [3:0]s3p3;
  reg [3:0]s4p1;
        reg [3:0]s4p2;
         reg [3:0]s4p3;
reg [3:0]s1m1;
  
  
  turn t(.clk(clk),.rst(rstk),.sw(1'b1),.next(nextt),.n(n),.num(num),.n1(n1t),.n2(n2t),.n3(n3t),.show1(show1t),.show2(show2t),.show3(show3t));
  assign flag_out = (!flag2) && flag1;
  always@(posedge clk,posedge rst)begin
      if(rst==1)begin
          flag1 <= 1'b0;
          flag2 <= 1'b0;
      end
      else begin
          flag1 <= next;
          flag2 <= flag1 ;
      end
  end
    
    always@(posedge clk)
    if(rst)
    state<=s1;
    else state<=next_state;
    
    always@(posedge clk)
     case (state)
        spw:show<={one,32'b11111111_11111111_11111111_11111111,show1t,show2t,show3t};
        sm:show<={two,32'b11111111_11111111_11111111_11111111,show1t,show2t,show3t};
        ok:show<={8'b11111111,_S,_U,_C,_C,_E,_S,_S};
      endcase
        
       
  
  
  /*  parameter spw=4'b0000;  //输入 密码
     parameter ok=4'b0001; //成功
     parameter fail=4'b0010;//失败
     parameter sm=4'b0011; //输入 金额
     parameter s1=4'b0100; //1 
     parameter s2=4'b0101; //1 
     parameter s3=4'b0110; //1 
     parameter s4=4'b0111; //1 */  
endmodule
