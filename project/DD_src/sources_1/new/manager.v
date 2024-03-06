`timescale 1ns / 1ps


module manager(
input clk,rst,rstk,sw,[0:0]next,[3:0]n,[2:0]mode,[9:0]moneyget,[9:0]timeget,swm, [0:0]nextt,//nextȷ�ϼ���������һ����num����С��������mode����״̬��ģʽѡ��swm��Ǯ����������
//moneyget��������Ǯtimeout���ճ���������ͣ��ʱ��
output reg[9:0]initial_money,reg [9:0]per_money,reg[9:0]num_of_park,reg[9:0]initial_vipmoney, reg [9:0]averagetime, reg empty,reg[63:0]show
//��ʼ�ۣ�ʱ�ۣ���λ������Ա�Żݣ�ƽ��ʱ�䣬showΪ��������ʾ��չʾ����


    );  //����Աģʽ��
    reg nextti;
integer sumofcar;
reg [9:0]totaltime; //��ʱ��
reg [9:0]totalmoney;  //�ܽ��
parameter set=3'b000;  //����  state
parameter ok=3'b001; //�ɹ�
parameter fail=3'b010;//ʧ��
parameter simoney=3'b011; //��ʾ�𲽼�
parameter spmoney=3'b100; //��ʾʱ��
parameter snopark=3'b101;//��ʾ��λ
parameter svmoney=3'b110;//��ʾ��Ա�۸�
parameter satime=3'b111;//��ʾƽ��ʱ�ۼ�

parameter set_initial_money=3'b001; //�����𲽼�   mode
parameter set_per_money=3'b010;  //����ʱ��
parameter set_initial_vipmoney=3'b011;  //���û�Ա�Ż��𲽼�
parameter empty_park=3'b100;  //��ճ��������ý��
parameter set_park=3'b101;  //���ó�λ��
parameter show_money=3'b110;   //��ʾ������
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
parameter _Z = 8'b10100101;   //z


reg swt;

wire [9:0]num;
wire [3:0]n1t;
wire [3:0]n2t;
wire [3:0]n3t;
wire [7:0]show1t;
wire [7:0]show2t;
wire [7:0]show3t;
reg [2:0]state;
reg [2:0]next_state;
wire[7:0]im1;
wire[7:0]im2;
wire[7:0]im3;
wire[7:0]pm1;
wire[7:0]pm2;
wire[7:0]pm3;
wire[7:0]vim1;
wire[7:0]vim2;
wire[7:0]vim3;
wire[7:0]np1;
wire[7:0]np2;
wire[7:0]np3;
wire[7:0]at1;
wire[7:0]at2;
wire[7:0]at3;

turn t(.clk(clk),.rst(rstk),.sw(swt),.next(nextt),.n(n),.num(num),.n1(n1t),.n2(n2t),.n3(n3t),.show1(show1t),.show2(show2t),.show3(show3t));
change im(.clk(clk),.n(initial_money),.s1(im1),.s2(im2),.s3(im3));
change pm(.clk(clk),.n(per_money),.s1(pm1),.s2(pm2),.s3(pm3));
change vim(.clk(clk),.n(initial_vipmoney),.s1(vim1),.s2(vim2),.s3(vim3));
change np(.clk(clk),.n(num_of_park),.s1(np1),.s2(np2),.s3(np3));
change at(.clk(clk),.n(averagetime),.s1(at1),.s2(at2),.s3(at3));
/*output reg[3:0]initial_money,reg [2:0]per_money,reg[3:0]num_of_park,reg[3:0]initial_vipmoney, reg [9:0]averagetime, reg empty,reg[63:0]show,
//��ʼ�ۣ�ʱ�ۣ���λ������Ա�Żݣ�ƽ��ʱ�䣬showΪ��������ʾ��չʾ����*/
reg e;
reg flag1;
reg flag2;
wire [0:0]flag_out;
always@(posedge clk)
 if(n==10)e=1'b1;
 else e=1'b0;
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

reg flag11;
reg flag22;
wire [0:0]flag_out1;
assign flag_out1 = (!flag22) && flag11;
always@(posedge clk,posedge rst)begin
	if(rst==1)begin
		flag11 <= 1'b0;
		flag22 <= 1'b0;
	end
	else begin
		flag11 <= next;
		flag22 <= flag11 ;
	end
end
  

always@(posedge clk)    
  
      if(rst)
         begin
       if(mode==show_money)
            begin
               state<=simoney;
            end
            else begin 
              state<=set;
            end
       end
      else begin
         if(flag_out)begin
            state<=next_state;          
         end
      end
       
     
     


     
always@(posedge clk)
  if(rst)begin
 
  initial_money<=9;
          per_money<=5;        
          initial_vipmoney<=8;
          swt=1'b1;
          num_of_park<=8;
          show<={8'b11111111,_M,_A,_N,_A,_G,_E,_R};    
end
  else 
  if(sw)begin    if(state==ok||state==fail)begin case(state)
   ok:
                                               show<={8'b11111111,_S,_U,_C,_C,_E,_S,_S};
                                           fail:
                                               show<={24'b11111111_11111111_11111111,_E,_R,_R,_O,_R};
                                               endcase
  end
  
  
  else if(sw)
                     case(mode)
                         set_initial_money:begin
                             show<={one,32'b11111111_11111111_11111111_11111111,show1t,show2t,show3t};
                             if(next&&num<20)
                             initial_money<=num;
                         end
                         set_per_money:begin
                             show<={two,32'b11111111_11111111_11111111_11111111,show1t,show2t,show3t}; 
                             if(next&&num<20)
                             per_money<=num;
                         end  
                         set_initial_vipmoney:begin
                             show<={three,32'b11111111_11111111_11111111_11111111,show1t,show2t,show3t}; 
                             if(next&&num<20)
                             initial_vipmoney<=num;
                         end
                         empty_park:
                             show<={four,16'b11111111_11111111,_E,_M,_P,_T,_Y}; 
                         set_park:begin
                             show<={five,32'b11111111_11111111_11111111_11111111,show1t,show2t,show3t};
                             if(next&&num<20)
                             num_of_park<=num;
                             end
                         show_money:
                             
                               case(state)
                                          simoney:
                                              show<={one,one,one,16'b11111111_11111111,im1,im2,im3};
                                          spmoney:
                                              show<={two,two,two,16'b11111111_11111111,pm1,pm2,pm3}; 
                                          snopark:
                                              show<={three,three,three,16'b11111111_11111111,np1,np2,np3};
                                          svmoney:
                                              show<={four,four,four,16'b11111111_11111111,vim1,vim2,vim3};
                                          satime: 
                                              show<={seven,seven,seven,16'b11111111_11111111,at1,at2,at3};
                                          default:
                                          show<={one,one,one,16'b11111111_11111111,im1,im2,im3};
                            
                                              endcase
                             
                             
                           
                     endcase    
                
             
             
         
end

always@(posedge clk)      
  
   
  
   
    begin
               
                   if(state==ok||state==fail)begin
                   next_state=set;
                   
                   end
                   
                   else
                   
                      //���ý׶�
                        case(mode)
                            set_initial_money:
                             if(num<20)
                                   next_state<=ok;
                                   else  next_state<=fail;
                           
                            set_per_money:
                          if(num<20)
                                   next_state<=ok;
                              else  next_state<=fail;
                            set_initial_vipmoney:
                               
                              if(num<20)
                                   next_state<=ok;
                                   else  next_state<=fail;
                            set_park:
                              if(num<20)
                                   next_state<=ok;
                                 else  next_state<=fail;
                            empty_park:
                                 next_state<=ok;
                          
                            show_money:
                            case(state)
                                
                            simoney:
                                 next_state<=spmoney;
                            spmoney:
                                 next_state<=snopark;
                            snopark:
                                 next_state<=svmoney;
                            svmoney:
                                 next_state<=satime;
                            default:
                                 next_state<= simoney;
                             endcase
                        endcase
                    end
  
         
     



always@(posedge clk,posedge swm)
  if(rst)begin
      totaltime<=0;
      totalmoney<=0;
  end
  else if(swm)begin
      totaltime<=totaltime+timeget;
      totalmoney<=totalmoney+moneyget;
      sumofcar<=sumofcar+1;
      averagetime<=totaltime/sumofcar;
  end




            
       
    /*parameter set=3'b000;  //����  state
            parameter ok=3'b001; //�ɹ�
            parameter fail=3'b010;//ʧ��
            parameter simoney=3'b011; //��ʾ�𲽼�
            parameter spmoney=3'b100; //��ʾʱ��
            parameter snopark=3'b101;//��ʾ��λ
            parameter svmoney=3'b110;//��ʾ��Ա�۸�
            parameter satime=3'b111;//��ʾƽ��ʱ�ۼ�*/
    

    


endmodule
