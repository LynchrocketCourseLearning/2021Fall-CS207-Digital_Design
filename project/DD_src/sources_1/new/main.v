`timescale 1ns / 1ps

module main(
    input clk,rst,sw, rstm,   rstk,       //时钟，复位，开关,管理员复位
    input come,place,stop_car,  //车来判断，车场选择，停车
    input leave,                //车辆离开
    input [3:0] outplace_carnum,
   input [0:0]next0,   [0:0]nextt,
    input   modem0,modem1,modem2,
  input sw1,
    input sw2,
    
    output beep,                 //蜂鸣器
    output [23:0] led,                  //流水彩灯
    input      [3:0] row,                 // 矩阵键盘 行
    output [3:0] col,                 // 矩阵键盘 列 
    output [7:0] seg_en,         //数码管使能信号
    output  [7:0] seg_out     //数码管字符显示
    );
    
//    music mu(.clk(clk),.sw(sw),.beep(beep));
    reg[2:0]modem;
    wire full_switch,empty_switch,count_down,empty;
    wire [127:0] car_leave_light;
    wire [119:0] information_light;
    wire [15:0] stop_place_num_light;
    wire [6:0] money,stop_time;
    wire [3:0] initial_money = 4'b1001 ;  
    wire [2:0] per_money = 3'b101;
    wire [3:0] place_number = 4'b1000;
     reg mode;
     reg pay;
     
       reg [127:0] text;
       wire [63:0]text1;
       wire [63:0]text2;
       wire[3:0]initialmoney;
       wire [2:0]permoney;
       wire[3:0]num_of_park;
       wire[3:0]initial_vipmoney;
       wire [9:0]averagetime;
       reg swm;//有钱来的上升沿
       reg[9:0]timeget;
       
    integer idcheck; //查找的id  
    integer passwordcheck;//查找的密码 
   
        
     show u2(.clk(clk),.rst(rst),.mode(mode),.text(text),.seg_en(seg_en),.seg_out(seg_out));
     
     wire [3:0] keyboard_val;
    
     wire [9:0] account;
     wire [55:0] pay_light;
     wire time_end;
     
     led l(.clk(clk),.st(sw),.led(led),.time_end(time_end));
     
     reg [6:0]timeout;
     reg [3:0]moneyget;
     reg [6:0]has_pay; 
     wire allpay;       //车主支付金额
     parking u1(.allpay(allpay),.change(sw2),.clk(clk),.come(come),.place(place),.rst(rst),.stop_car(stop_car),.sw(sw),.leave(leave),.count_down(count_down)
     ,.money(money),.stop_time(stop_time),.full_switch(full_switch),.empty_switch(empty_switch),.outplace_carnum(outplace_carnum),.
     car_leave_light(car_leave_light),.information_light(information_light),.stop_place_num_light(stop_place_num_light),.empty(empty)
     ,.initial_money(initial_money),.per_money(per_money),.place_number(place_number),.pay(pay),.keyboard_val(keyboard_val),.pay_light(pay_light),.time_end(time_end));

//     vip_apply va(.clk(clk),.rst(rst),.sw(sw1),.pay(pay),.num(keyboard_val),.next(next0),.show(text1),.idcheck(idcheck),.passwordcheck(passwordcheck),.account(account));
     key16 k(.clk(clk),.enable(rst),.row(row),.col(col),.keyboard_val(keyboard_val));
     
//     manager m(.clk(clk),.rst(rst),.sw(sw2),.next(next0),.num(keyboard_val),.timeout(timeout),.state(state),.moneyget(moneyget),.initial_money(initialmoney),.per_money(permoney),.num_of_park(num_of_park)
//     ,.initial_vipmoney(initial_vipmoney),.averagetime(averagetime),.empty(empty),.show(text2));
    
    manager m(.clk(clk),.rst(rstm),.sw(sw2),.rstk(rstk),.next(next0),.n(keyboard_val),.mode(modem),.moneyget(moneyget),.timeget(timeget),.swm(swm),.initial_money(initialmoney),.per_money(permoney),.num_of_park(num_of_park)
     ,.initial_vipmoney(initial_vipmoney),.averagetime(averagetime),.empty(empty),.show(text2),.nextt(nextt));
    
    always@(posedge clk)
    begin
        modem<={modem2,modem1,modem0};
    end 
    always@(posedge clk)//if(sw1)begin
//        text=text1;
//    end
//    else if(sw2)begin
//        text=text2;
//    end 
//    else
//    begin
      if(sw2)begin text<=text2;mode<=1'b0;end
     else
        if(come && full_switch && ~stop_car && ~leave && ~sw2 && sw) begin
            text = 32'b10001110_11000001_11000111_11000111;
            mode = 1'b0;
        end
        else if(come && ~full_switch && stop_car && ~leave && ~sw2 && sw) begin
            text =  stop_place_num_light;
            mode = 1'b0;
        end
        else if(~come && ~stop_car && empty_switch &&leave && ~sw2 && sw) begin
            text =40'b10000110_11001000_10001100_10000111_10010001;
            mode = 1'b0;
        end
        else if(~come && ~stop_car && ~empty_switch &&leave && ~sw2 && sw) begin
            text = car_leave_light;
            mode = 1'b1;
        end
        else if (~come && ~stop_car &&~leave && ~pay&&~sw2 &&~pay&& sw) begin
            text = information_light;
            mode = 1'b1;
        end
        else if(~come && ~stop_car && ~empty_switch &&leave&&allpay == 1&&pay && ~sw2 && sw)begin
        text = pay_light;
        mode = 1'b0;
        end
        else begin
        text = 8'b00000000;
        mode = 1'b1;
        end

endmodule
/*
module main(
    input clk,rst,sw,           //时钟，复位，开关
    input come,place,stop_car,  //车来判断，车场选择，停车
    input leave,                //车辆离开
    input [3:0] outplace_carnum,
    input next0,   
    input  [2:0] state,
    input sw1,
    input sw2,
    input pay,
    input rstm,  //管理员模式复位信号
    input [2:0]modem,
    output beep,                 //蜂鸣器
    output [23:0] led,                  //流水彩灯
    input      [3:0] row,                 // 矩阵键盘 行
    output [3:0] col,                 // 矩阵键盘 列 
    output [7:0] seg_en,         //数码管使能信号
    output  [7:0] seg_out     //数码管字符显示
    );
    
    music mu(.clk(clk),.sw(sw),.beep(beep));
    
    wire full_switch,empty_switch,count_down,empty;
    wire [127:0] car_leave_light;
    wire [119:0] information_light;
    wire [15:0] stop_place_num_light;
    wire [6:0] money,stop_time;
    wire [3:0] initial_money = 4'b1001 ;  
    wire [2:0] per_money = 3'b101;
    wire [3:0] place_number = 4'b1000;
    reg mode;
    reg [127:0] text;
    wire [63:0]text1;
    wire [63:0]text2;
    wire[3:0]initialmoney;
    wire [2:0]permoney;
    wire[3:0]num_of_park;
    wire[3:0]initial_vipmoney;
    wire [9:0]averagetime;
    reg svm;//有钱来的上升沿
  
       
    integer idcheck; //查找的id  
    integer passwordcheck;//查找的密码 
   
        
     show u2(.clk(clk),.rst(rst),.mode(mode),.text(text),.seg_en(seg_en),.seg_out(seg_out));
     
     wire [3:0] keyboard_val;
    
     wire [9:0] account;
     wire [55:0] pay_light;
     wire time_end;
     
     led l(.clk(clk),.enable(sw),.led(led),.time_end(time_end));
     
     reg [6:0]timeget;
     reg [3:0]moneyget;
     reg [6:0]has_pay;        //车主支付金额
     parking u1(.change(sw2),.clk(clk),.come(come),.place(place),.rst(rst),.stop_car(stop_car),.sw(sw),.leave(leave),.count_down(count_down)
     ,.money(money),.stop_time(stop_time),.full_switch(full_switch),.empty_switch(empty_switch),.outplace_carnum(outplace_carnum),.
     car_leave_light(car_leave_light),.information_light(information_light),.stop_place_num_light(stop_place_num_light),.empty(empty)
     ,.initial_money(initial_money),.per_money(per_money),.place_number(place_number),.pay(pay),.keyboard_val(keyboard_val),.pay_light(pay_light),.time_end(time_end));



     
     manager m(.clk(clk),.rst(rst),.sw(sw2),.next(next0),.n(keyboard_val),.modem(mode),.moneyget(moneyget),.timeget(timeget),.svm(svm),.initial_money(initialmoney),.per_money(permoney),.num_of_park(num_of_park)
     ,.initial_vipmoney(initial_vipmoney),.averagetime(averagetime),.empty(empty),.show(text2));
     
    always@(clk)
    begin
        if(come && full_switch && ~stop_car && ~leave && ~sw2 && sw) begin
            text = 32'b10001110_11000001_11000111_11000111;
            mode = 1'b0;
        end
        else if(come && ~full_switch && stop_car && ~leave && ~sw2 && sw) begin
            text =  stop_place_num_light;
            mode = 1'b0;
        end
        else if(~come && ~stop_car && empty_switch &&leave && ~sw2 && sw) begin
            text =40'b10000110_11001000_10001100_10000111_10010001;
            mode = 1'b0;
        end
        else if(~come && ~stop_car && ~empty_switch &&leave && ~sw2 && sw) begin
            text = car_leave_light;
            mode = 1'b1;
        end
        else if (~come && ~stop_car &&~leave && ~sw2 && sw) begin
            text = information_light;
            mode = 1'b1;
        end
        else begin
        text = 8'b00000000;
        mode = 1'b1;
        end
    end
endmodule

*/
