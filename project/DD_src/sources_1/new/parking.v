`timescale 1ns / 1ps

module parking(
    input clk,
    input sw,
    input rst,
    //来车
    input come, place, stop_car,
    output reg full_switch,
    output reg [15:0] stop_place_num_light, 
    //出车
    input leave,
    input [3:0] outplace_carnum,
    output reg count_down,empty_switch,
    output reg [6:0] money,stop_time,//传给支付模式
    output reg [127:0] car_leave_light,
    input [3:0]keyboard_val,
    //支付
    input pay,
//    vip,
//    input [6:0]has_pay,
//    output [6:0] store_money,
    //管理员控制
    input empty,change,
    input [3:0] initial_money,   
    input [2:0] per_money,
    input [3:0] place_number,
    output reg [119:0] information_light,
    output reg [55:0] pay_light,
    input time_end,
    output reg allpay
);
//reg [3:0]initial_mon;
//reg [2:0]per;
//reg [3:0]place_num;
//reg [2:0]empty_place;
//reg clk_bps,isfull;
//reg [3:0] a_rest,b_rest;
    reg [6:0] carplaceA[7:0],carplaceB[7:0];//停车时间
    wire [7:0] A,B;
    reg A0,A1,A2,A3,A4,A5,A6,A7,B0,B1,B2,B3,B4,B5,B6,B7;//是否有车
    reg [2:0]empty_place;//停车位置
    reg [15:0] stop_time_light,money_light;//停车时间显示和需交费用显示
    reg [3:0]initial_mon;//起步价
    reg [2:0]per;//时价
    reg [3:0]place_num;//车位数量
    reg [13:0] cnt_first,cnt_second;
    reg [7:0] initial_money_light,place_number_light,A_light,B_light;
    reg [7:0] per_money_light,A_rest_light,B_rest_light;
    integer i,j,restA,restB;
    reg [7:0]haspay;
    reg pay_off;
    reg [1:0]t1;
    assign A = {A0,A1,A2,A3,A4,A5,A6,A7};
    assign B = {B0,B1,B2,B3,B4,B5,B6,B7};
    always@(posedge clk)
        if(cnt_first ==14'd10000)
        cnt_first<= 14'd0;
        else cnt_first <= cnt_first+1'b1;
    always@(posedge clk)
        if(cnt_second == 14'd10000) cnt_second <= 14'd0;
        else if (cnt_first == 14'd10000) cnt_second<=cnt_second+1'b1;
    always@(keyboard_val or rst) begin
    if(rst ==1) begin
        t1 =0;
        haspay = 0;
    end
    else begin
        if(keyboard_val == 4'hA) begin
            allpay = 0;
            t1 = 0;
        end
        if(keyboard_val == 4'hD) begin
                    allpay = 1;
                    t1 = 0;
         end
        if(pay&&allpay == 0)begin
        if(t1 == 0) begin
            haspay = keyboard_val*10+haspay;
            t1 = t1+1;
        end
        if(t1 ==1) begin
            haspay =keyboard_val+haspay;
            t1 = t1+1;
        end
        end
    end
    end
    always @(posedge clk) begin
        if(cnt_second == 14'd10000) begin
            if(A0==1&&carplaceA[0]<99) carplaceA[0]<=carplaceA[0]+1;
            if(A1==1&&carplaceA[1]<99) carplaceA[1]<=carplaceA[1]+1;
            if(A2==1&&carplaceA[2]<99) carplaceA[2]<=carplaceA[2]+1;
            if(A3==1&&carplaceA[3]<99) carplaceA[3]<=carplaceA[3]+1;
            if(A4==1&&carplaceA[4]<99) carplaceA[4]<=carplaceA[4]+1;
            if(A5==1&&carplaceA[5]<99) carplaceA[5]<=carplaceA[5]+1;
            if(A6==1&&carplaceA[6]<99) carplaceA[6]<=carplaceA[6]+1;
            if(A7==1&&carplaceA[7]<99) carplaceA[7]<=carplaceA[7]+1;
            if(B0==1&&carplaceB[0]<99) carplaceB[0]<=carplaceA[0]+1;
            if(B1==1&&carplaceB[1]<99) carplaceB[1]<=carplaceB[1]+1;
            if(B2==1&&carplaceB[2]<99) carplaceB[2]<=carplaceB[2]+1;
            if(B3==1&&carplaceB[3]<99) carplaceB[3]<=carplaceB[3]+1;
            if(B4==1&&carplaceB[4]<99) carplaceB[4]<=carplaceB[4]+1;
            if(B5==1&&carplaceB[5]<99) carplaceB[5]<=carplaceB[5]+1;
            if(B6==1&&carplaceB[6]<99) carplaceB[6]<=carplaceB[6]+1;
            if(B7==1&&carplaceB[7]<99) carplaceB[7]<=carplaceB[7]+1;
        end
    end
always @(posedge clk) begin
    if(empty&&sw&&come ==0&&leave ==0&&stop_car==0) begin
        {A0,A1,A2,A3,A4,A5,A6,A7} = 8'b00000000;
        {B0,B1,B2,B3,B4,B5,B6,B7} = 8'b00000000;    
    end
    if(~change&&sw&&come ==0&&leave ==0&&stop_car == 0) begin
        restA = 0;
        restB = 0;
        initial_mon = initial_money;
        place_num = place_number;
        per = per_money;
        i = 0;
        if(i<place_num) begin
            if(A0 == 0) begin
                restA = restA+1;
            end
            i = i+1;
        end
        if(i<place_num) begin
            if(A1 == 0) begin
                restA = restA+1;
            end
            i = i+1;
        end
        if(i<place_num) begin
            if(A2 == 0) begin
                restA = restA+1;
            end
            i = i+1;
        end
        if(i<place_num) begin
            if(A3 == 0) begin
                restA = restA+1;
            end
            i = i+1;
        end
        if(i<place_num) begin
            if(A4 == 0) begin
                restA = restA+1;
            end
            i = i+1;
        end
        if(i<place_num) begin
            if(A5 == 0) begin
                restA = restA+1;
            end
            i = i+1;
        end
        if(i<place_num) begin
            if(A6 == 0) begin
                restA = restA+1;
            end
            i = i+1;
        end
        if(i<place_num) begin
            if(A7 == 0) begin
                restA = restA+1;
            end
            i = i+1;
        end
        i = 0;
        if(i<place_num) begin
            if(B0 == 0) begin
                restB = restB+1;
            end
            i = i+1;
        end
        if(i<place_num) begin
            if(B1 == 0) begin
                restB = restB+1;
            end
            i = i+1;
        end
        if(i<place_num) begin
            if(B2 == 0) begin
                restB = restB+1;
            end
            i = i+1;
        end
        if(i<place_num) begin
            if(B3 == 0) begin
                restB = restB+1;
            end
            i = i+1;
        end
        if(i<place_num) begin
            if(B4 == 0) begin
                restB = restB+1;
            end
            i = i+1;
        end
        if(i<place_num) begin
            if(B5 == 0) begin
                restB = restB+1;
            end
            i = i+1;
        end
        if(i<place_num) begin
            if(B6 == 0) begin
                restB = restB+1;
            end
            i = i+1;
        end
        if(i<place_num) begin
            if(B7 == 0) begin
                restB = restB+1;
            end
            i = i+1;
        end
        case (restA)
            4'b0000:A_rest_light = 8'b11000000;
            4'b0001:A_rest_light = 8'b11111001;
            4'b0010:A_rest_light = 8'b10100100;
            4'b0011:A_rest_light = 8'b10110000;
            4'b0100:A_rest_light = 8'b10011001;
            4'b0101:A_rest_light = 8'b10010010;
            4'b0110:A_rest_light = 8'b10000010;
            4'b0111:A_rest_light = 8'b11111000;
            4'b1000:A_rest_light = 8'b10000000;
            default:A_rest_light = 8'b11111111;
        endcase
        case (restB)
            4'b0000:B_rest_light= 8'b11000000;
            4'b0001:B_rest_light = 8'b11111001;
            4'b0010:B_rest_light = 8'b10100100;
            4'b0011:B_rest_light = 8'b10110000;
            4'b0100:B_rest_light = 8'b10011001;
            4'b0101:B_rest_light = 8'b10010010;
            4'b0110:B_rest_light = 8'b10000010;
            4'b0111:B_rest_light = 8'b11111000;
            4'b1000:A_rest_light = 8'b10000000;
            default:B_rest_light = 8'b11111111;
        endcase
        case (initial_mon)
            4'b0000:initial_money_light = 8'b11000000;
            4'b0001:initial_money_light = 8'b11111001;
            4'b0010:initial_money_light = 8'b10100100;
            4'b0011:initial_money_light = 8'b10110000;
            4'b0100:initial_money_light = 8'b10011001;
            4'b0101:initial_money_light = 8'b10010010;
            4'b0110:initial_money_light = 8'b10000010;
            4'b0111:initial_money_light = 8'b11111000;
            4'b1000:initial_money_light = 8'b10000000;
            4'b1001:initial_money_light = 8'b10010000;
            default:initial_money_light = 8'b11111111;
        endcase
        case (per)
            4'b0000:per_money_light = 8'b11000000;
            4'b0001:per_money_light = 8'b11111001;
            4'b0010:per_money_light = 8'b10100100;
            4'b0011:per_money_light = 8'b10110000;
            4'b0100:per_money_light = 8'b10011001;
            4'b0101:per_money_light = 8'b10010010;
            4'b0110:per_money_light = 8'b10000010;
            4'b0111:per_money_light = 8'b11111000;
            default:per_money_light = 8'b11111111;
        endcase
//        case (carplaceB[0]/10)
//            4'b0000:A_light = 8'b11000000;
//            4'b0001:A_light = 8'b11111001;
//            4'b0010:A_light = 8'b10100100;
//            4'b0011:A_light = 8'b10110000;
//            4'b0100:A_light = 8'b10011001;
//            4'b0101:A_light = 8'b10010010;
//            4'b0110:A_light = 8'b10000010;
//            4'b0111:A_light = 8'b11111000;
//            4'b1000:A_light = 8'b10000000;
//            default:A_light = 8'b11111111;
//        endcase
//        case (carplaceB[0]-(carplaceB[0]/10)*10)
//                    4'b0000:B_light = 8'b11000000;
//                    4'b0001:B_light = 8'b11111001;
//                    4'b0010:B_light = 8'b10100100;
//                    4'b0011:B_light = 8'b10110000;
//                    4'b0100:B_light = 8'b10011001;
//                    4'b0101:B_light = 8'b10010010;
//                    4'b0110:B_light = 8'b10000010;
//                    4'b0111:B_light = 8'b11111000;
//                    4'b1000:B_light = 8'b10000000;
//                    default:B_light = 8'b11111111;
//                endcase
         information_light = {8'b10001000,A_rest_light,8'b11111111,8'b10000011,B_rest_light,8'b11111111,16'b10110110_10000111,initial_money_light,8'b11111111,16'b10000110_10001000,per_money_light};
    end
    if(sw&&rst&&come ==0&&leave ==0&&stop_car==0)begin
        {A0,A1,A2,A3,A4,A5,A6,A7} = 8'b00000000;
        {B0,B1,B2,B3,B4,B5,B6,B7} = 8'b00000000;
        full_switch = 0;
        initial_mon = 4'b1001;
        place_num = 4'b1000;
        per = 3'b101;
end
if(sw == 1&&come ==1&&leave ==0&&stop_car == 0) begin
        full_switch = 0;
        if(place == 1) begin
            if(A0 == 0) begin
                empty_place = 3'b000;
            end
            else if(A1 ==0) begin
                empty_place = 3'b001;
            end
            else if(A2 ==0) begin
                empty_place = 3'b010;
            end
            else if(A3 ==0) begin
                empty_place = 3'b011;
            end
            else if(A4 ==0) begin
                empty_place = 3'b100;
            end
            else if(A5 ==0) begin
                empty_place = 3'b101;
            end
            else if(A6 ==0) begin
                empty_place = 3'b110;
            end
            else if(A7 ==0) begin
                empty_place = 3'b111;
            end
            else begin
            full_switch = 1;
            end
            if(empty_place>=place_num) full_switch = 1;
        end
        else begin
            if(B0 == 0) begin
                empty_place = 000;
            end
            else if(B1 == 0) begin
                empty_place = 001;
            end
            else if(B2 == 0) begin
                empty_place = 010;
            end
            else if(B3 == 0) begin
                empty_place = 011;
            end
            else if(B4 == 0) begin
                empty_place = 100;
            end
            else if(B5 == 0) begin
                empty_place = 101;
            end
            else if(B6 == 0) begin
                empty_place = 110;
            end
            else if(B7 == 0) begin
                empty_place = 111;
            end
            else begin
            full_switch = 1;
            end
            if(empty_place>=place_num) full_switch = 1;
        end
end
if(sw == 1&&come ==1&&full_switch == 0&&leave ==0&&stop_car == 1) begin
 if(cnt_second == 14'd1000)begin
        if(place)
            case(empty_place)
                3'b000:begin stop_place_num_light = 16'b10001000_11000000;A0 = 1;end
                3'b001:begin stop_place_num_light = 16'b10001000_11111001;A1 = 1;end
                3'b010:begin stop_place_num_light = 16'b10001000_10100100;A2 = 1;end
                3'b011:begin stop_place_num_light = 16'b10001000_10110000;A3 = 1;end
                3'b100:begin stop_place_num_light = 16'b10001000_10011001;A4 = 1;end
                3'b101:begin stop_place_num_light = 16'b10001000_10010010;A5 = 1;end
                3'b110:begin stop_place_num_light = 16'b10001000_10000010;A6 = 1;end
                3'b111:begin stop_place_num_light = 16'b10001000_11111000;A7 = 1;end
                default:stop_place_num_light = 16'b11111111_11111111;
            endcase
        else 
            case(empty_place)
                3'b000:begin stop_place_num_light = 16'b10000011_11000000;B0 = 1;end
                3'b001:begin stop_place_num_light = 16'b10000011_11111001;B1 = 1;end
                3'b010:begin stop_place_num_light = 16'b10000011_10100100;B2 = 1;end
                3'b011:begin stop_place_num_light = 16'b10000011_10110000;B3 = 1;end
                3'b100:begin stop_place_num_light = 16'b10000011_10011001;B4 = 1;end
                3'b101:begin stop_place_num_light = 16'b10000011_10010010;B5 = 1;end
                3'b110:begin stop_place_num_light = 16'b10000011_10000010;B6 = 1;end
                3'b111:begin stop_place_num_light = 16'b10000011_11111000;B7 = 1;end
                default:stop_place_num_light = 16'b11111111_11111111;
            endcase
end
end
if(sw == 1&&come ==0&&full_switch == 0&&leave ==1&&stop_car == 0&&allpay ==0) begin
        empty_switch = 0;
        if(place) begin
            case(outplace_carnum)
                3'b000:if(A0 == 1) begin
                            stop_time = carplaceA[0];
                            if(carplaceA[0]>10) money = initial_mon+per*10;
                            else money = initial_mon+stop_time*per;
                       end
                       else empty_switch = 1;
                3'b001:if(A1 == 1) begin
                            stop_time = carplaceA[1];
                            if(carplaceA[1]>10) money = initial_mon+per*10;
                            else money = initial_mon+stop_time*per;
                       end
                       else empty_switch = 1;
                 3'b010:if(A2 == 1) begin
                           stop_time = carplaceA[2];
                           if(carplaceA[2]>10) money = initial_mon+per*10;
                           else money = initial_mon+stop_time*per;
                       end
                       else empty_switch = 1;                      
                3'b011:if(A3 == 1) begin
                           stop_time = carplaceA[3];
                           if(carplaceA[3]>10) money = initial_mon+per*10;
                              else money = initial_mon+stop_time*per;
                       end
                       else empty_switch = 1;                       
                3'b100:if(A4 == 1) begin
                           stop_time = carplaceA[4];
                           if(carplaceA[4]>10) money = initial_mon+per*10;
                              else money = initial_mon+stop_time*per;
                       end
                       else empty_switch = 1;                       
                3'b101:if(A5 == 1) begin
                           stop_time = carplaceA[5];
                           if(carplaceA[5]>10) money = initial_mon+per*10;
                              else money = initial_mon+stop_time*per;
                       end
                       else empty_switch = 1;   
                3'b110:if(A6 == 1) begin
                           stop_time = carplaceA[6];
                           if(carplaceA[6]>10) money = initial_mon+per*10;
                              else money = initial_mon+stop_time*per;
                       end
                       else empty_switch = 1;
                3'b111:if(A7 == 1) begin
                           stop_time = carplaceA[7];
                           if(carplaceA[7]>10) money = initial_mon+per*10;
                              else money = initial_mon+stop_time*per;
                       end
                       else empty_switch = 1;                                                       
            endcase
        end
        else begin
            case(outplace_carnum)
                3'b000:if(B0 == 1) begin
                            stop_time = carplaceB[0];
                            if(carplaceB[0]>10) money = initial_mon+per*10;
                            else money = initial_mon+stop_time*per;
                       end
                       else empty_switch = 1;
                3'b001:if(B1 == 1) begin
                            stop_time = carplaceB[1];
                            if(carplaceB[1]>10) money = initial_mon+per*10;
                            else money = initial_mon+stop_time*per;
                       end
                       else empty_switch = 1;
                3'b010:if(B2 == 1) begin
                            stop_time = carplaceB[2];
                            if(carplaceB[2]>10) money = initial_mon+per*10;
                            else money = initial_mon+stop_time*per;
                       end
                       else empty_switch = 1;                      
                3'b011:if(B3 == 1) begin
                            stop_time = carplaceB[3];
                            if(carplaceB[3]>10) money = initial_mon+per*10;
                            else money = initial_mon+stop_time*per;
                       end
                       else empty_switch = 1;                       
                 3'b100:if(B4 == 1) begin
                             stop_time = carplaceB[4];
                             if(carplaceB[4]>10) money = initial_mon+per*10;
                             else money = initial_mon+stop_time*per;
                        end
                        else empty_switch = 1;                       
                 3'b101:if(B5 == 1) begin
                             stop_time = carplaceB[5];
                             if(carplaceB[5]>10) money = initial_mon+per*10;
                             else money = initial_mon+stop_time*per;
                        end
                        else empty_switch = 1;   
                 3'b110:if(B6 == 1) begin
                             stop_time = carplaceB[6];
                             if(carplaceB[6]>10) money = initial_mon+per*10;
                             else money = initial_mon+stop_time*per;
                        end
                        else empty_switch = 1;
                 3'b111:if(B7 == 1) begin
                             stop_time = carplaceB[7];
                             if(carplaceB[7]>10) money = initial_mon+per*10;
                             else money = initial_mon+stop_time*per;
                        end
                        else empty_switch = 1;                                                       
            endcase
        end 
        case (stop_time/10)
            4'b0000:stop_time_light[15:8] = 8'b11000000;
            4'b0001:stop_time_light[15:8] = 8'b11111001;
            4'b0010:stop_time_light[15:8] = 8'b10100100;
            4'b0011:stop_time_light[15:8] = 8'b10110000;
            4'b0100:stop_time_light[15:8] = 8'b10011001;
            4'b0101:stop_time_light[15:8] = 8'b10010010;
            4'b0110:stop_time_light[15:8] = 8'b10000010;
            4'b0111:stop_time_light[15:8] = 8'b11111000;
            4'b1000:stop_time_light[15:8] = 8'b10000000;
            4'b1001:stop_time_light[15:8] = 8'b10010000;
            default: stop_time_light[15:8] = 8'b11111111;
        endcase
        case (stop_time-10*(stop_time/10))
            4'b0000:stop_time_light[7:0] = 8'b11000000;
            4'b0001:stop_time_light[7:0] = 8'b11111001;
            4'b0010:stop_time_light[7:0] = 8'b10100100;
            4'b0011:stop_time_light[7:0] = 8'b10110000;
            4'b0100:stop_time_light[7:0] = 8'b10011001;
            4'b0101:stop_time_light[7:0] = 8'b10010010;
            4'b0110:stop_time_light[7:0] = 8'b10000010;
            4'b0111:stop_time_light[7:0] = 8'b11111000;
            4'b1000:stop_time_light[7:0] = 8'b10000000;
            4'b1001:stop_time_light[7:0] = 8'b10010000;
            default: stop_time_light[7:0] = 8'b11111111;
        endcase
        case (money/10)
            4'b0000:money_light[15:8] = 8'b11000000;
            4'b0001:money_light[15:8] = 8'b11111001;
            4'b0010:money_light[15:8] = 8'b10100100;
            4'b0011:money_light[15:8] = 8'b10110000;
            4'b0100:money_light[15:8] = 8'b10011001;
            4'b0101:money_light[15:8] = 8'b10010010;
            4'b0110:money_light[15:8] = 8'b10000010;
            4'b0111:money_light[15:8] = 8'b11111000;
            4'b1000:money_light[15:8] = 8'b10000000;
            4'b1001:money_light[15:8] = 8'b10010000;
            default: money_light[15:8] = 8'b11111111;            
        endcase
        case (money-(money/10)*10)
            4'b0000:money_light[7:0] = 8'b11000000;
            4'b0001:money_light[7:0] = 8'b11111001;
            4'b0010:money_light[7:0] = 8'b10100100;
            4'b0011:money_light[7:0] = 8'b10110000;
            4'b0100:money_light[7:0] = 8'b10011001;
            4'b0101:money_light[7:0] = 8'b10010010;
            4'b0110:money_light[7:0] = 8'b10000010;
            4'b0111:money_light[7:0] = 8'b11111000;
            4'b1000:money_light[7:0] = 8'b10000000;
            4'b1001:money_light[7:0] = 8'b10010000;
            default: money_light[7:0] = 8'b11111111;            
        endcase
        count_down = ~count_down;
        pay_off = 0;
        car_leave_light = {32'b10000111_11110000_11001000_10000110,8'b11111111,stop_time_light,8'b1111111,40'b11001000_10100011_10101011_10000110_10010001,8'b11111111,money_light};
end
if(sw == 1&&come ==0&&full_switch == 0&&leave ==1&&stop_car == 0&&allpay ==1&&time_end== 0) begin
pay_light =56'b10000111_11110000_11001000_10000110_10000110_10101011_10100001 ;
end
if(sw == 1&&come ==0&&full_switch == 0&&leave ==1&&stop_car == 0&&allpay ==1&&time_end== 0&&pay_off ==0) begin
    if (money<haspay)begin
        money = haspay-money;
         case (money/10)
                            4'b0000: pay_light[15:8] = 8'b11000000;
                            4'b0001: pay_light[15:8] = 8'b11111001;
                            4'b0010: pay_light[15:8] = 8'b10100100;
                            4'b0011: pay_light[15:8] = 8'b10110000;
                            4'b0100: pay_light[15:8] = 8'b10011001;
                            4'b0101: pay_light[15:8] = 8'b10010010;
                            4'b0110: pay_light[15:8] = 8'b10000010;
                            4'b0111: pay_light[15:8] = 8'b11111000;
                            4'b1000: pay_light[15:8] = 8'b10000000;
                            4'b1001: pay_light[15:8] = 8'b10010000;
                            default: pay_light[15:8] = 8'b11111111;
                         endcase
                         case (money-(money/10)*10)
                             4'b0000: pay_light[7:0] = 8'b11000000;
                             4'b0001: pay_light[7:0] = 8'b11111001;
                             4'b0010: pay_light[7:0] = 8'b10100100;
                             4'b0011: pay_light[7:0] = 8'b10110000;
                             4'b0100: pay_light[7:0] = 8'b10011001;
                             4'b0101: pay_light[7:0] = 8'b10010010;
                             4'b0110: pay_light[7:0] = 8'b10000010;
                             4'b0111: pay_light[7:0] = 8'b11111000;
                             4'b1000: pay_light[7:0] = 8'b10000000;
                             4'b1001: pay_light[7:0] = 8'b10010000;
                             default: pay_light[7:0] = 8'b11111111;
                         endcase
            pay_light[55:16] =40'b10101011_10000110_10000110_10100001_11111111;
            count_down = ~count_down;
    end
    else begin
        money = haspay-money;
        case (money/10)
            4'b0000: pay_light[15:8] = 8'b11000000;
            4'b0001: pay_light[15:8] = 8'b11111001;
            4'b0010: pay_light[15:8] = 8'b10100100;
            4'b0011: pay_light[15:8] = 8'b10110000;
            4'b0100: pay_light[15:8] = 8'b10011001;
            4'b0101: pay_light[15:8] = 8'b10010010;
            4'b0110: pay_light[15:8] = 8'b10000010;
            4'b0111: pay_light[15:8] = 8'b11111000;
            4'b1000: pay_light[15:8] = 8'b10000000;
            4'b1001: pay_light[15:8] = 8'b10010000;
            default: pay_light[15:8] = 8'b11111111;
        endcase
        case (money-(money/10)*10)
            4'b0000: pay_light[7:0] = 8'b11000000;
            4'b0001: pay_light[7:0] = 8'b11111001;
            4'b0010: pay_light[7:0] = 8'b10100100;
            4'b0011: pay_light[7:0] = 8'b10110000;
            4'b0100: pay_light[7:0] = 8'b10011001;
            4'b0101: pay_light[7:0] = 8'b10010010;
            4'b0110: pay_light[7:0] = 8'b10000010;
            4'b0111: pay_light[7:0] = 8'b11111000;
            4'b1000: pay_light[7:0] = 8'b10000000;
            4'b1001: pay_light[7:0] = 8'b10010000;
            default: pay_light[7:0] = 8'b11111111;
        endcase
        pay_light[55:16] =40'b10000011_10001000_11000110_10001010_11111111;
        if(place) begin
            case(outplace_carnum)
                3'b000:A0 = 1;
                3'b001:A1 = 1;
                3'b010:A2 = 1;
                3'b011:A3 = 1;
                3'b100:A4 = 1;
                3'b101:A5 = 1;
                3'b110:A6 = 1;
                3'b111:A7 = 1;
            endcase
        end
        else begin
            case(outplace_carnum)
                3'b000:B0 = 1;
                3'b001:B1 = 1;
                3'b010:B2 = 1;
                3'b011:B3 = 1;
                3'b100:B4 = 1;
                3'b101:B5 = 1;
                3'b110:B6 = 1;
                3'b111:B7 = 1;
            endcase
        end
        pay_off =1;
    end
end
end
endmodule