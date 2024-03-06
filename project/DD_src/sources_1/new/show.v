`timescale 1ns / 1ps

//ÊıÂë¹ÜÏÔÊ¾
module show (
    input clk, rst, 
    input mode,
    input [127:0] text,
    output [7:0] seg_en,
    output reg [7:0] seg_out
    );
    
    wire [7:0] tube_char[15:0];
    assign tube_char[0] = text[7:0];
    assign tube_char[1] = text[15:8];
    assign tube_char[2] = text[23:16];
    assign tube_char[3] = text[31:24];
    assign tube_char[4] = text[39:32];
    assign tube_char[5] = text[47:40];
    assign tube_char[6] = text[55:48];
    assign tube_char[7] = text[63:56];
    assign tube_char[8] = text[71:64];
    assign tube_char[9] = text[79:72];
    assign tube_char[10] = text[87:80];
    assign tube_char[11] = text[95:88];
    assign tube_char[12] = text[103:96];
    assign tube_char[13] = text[111:104];
    assign tube_char[14] = text[119:112];
    assign tube_char[15] = text[127:120];

    reg [7:0] seg_en_r;
    assign seg_en = ~seg_en_r;
    
    wire clk_out;//update
    wire clk_move;//move
    fre_div #(200000,50000000) fd(.clk(clk),.rst(rst),.clk_m(clk_move),.clk_o(clk_out));

    reg [2:0] select;
    always @(posedge clk_out, posedge rst) begin
        if(rst)
            select <= 0;
        else begin
            select <= select + 1;
            if(select == 3'b111)
                select <= 0;
        end
    end
    
    always @(select) begin
        case(select)
            3'b000: seg_en_r = 8'b0000_0001;
            3'b001: seg_en_r = 8'b0000_0010;
            3'b010: seg_en_r = 8'b0000_0100;
            3'b011: seg_en_r = 8'b0000_1000;
            3'b100: seg_en_r = 8'b0001_0000;
            3'b101: seg_en_r = 8'b0010_0000;
            3'b110: seg_en_r = 8'b0100_0000;
            3'b111: seg_en_r = 8'b1000_0000;
            default: seg_en_r = 8'b0000_0000;
        endcase
    end

    reg [7:0] ind = 6'b0;
    always @(posedge clk_move, posedge rst) begin
        if(rst)
            ind <= 8'd143; 
        else begin
            ind <= ind - 1'b1;
            if(ind == 8'd0)
                ind <= 8'd143;
        end   
    end

    always @(select, ind) begin
        if(mode) begin
            case(select)
                3'b000: seg_out = tube_char[(ind+121)%128];
                3'b001: seg_out = tube_char[(ind+122)%128];
                3'b010: seg_out = tube_char[(ind+123)%128];
                3'b011: seg_out = tube_char[(ind+124)%128];
                3'b100: seg_out = tube_char[(ind+125)%128];
                3'b101: seg_out = tube_char[(ind+126)%128];
                3'b110: seg_out = tube_char[(ind+127)%128];
                3'b111: seg_out = tube_char[(ind+128)%128];
                default:seg_out = 8'b1111_1111;
            endcase
        end
        else begin
            case(select)
                3'b000: seg_out = tube_char[0];
                3'b001: seg_out = tube_char[1];
                3'b010: seg_out = tube_char[2];
                3'b011: seg_out = tube_char[3];
                3'b100: seg_out = tube_char[4];
                3'b101: seg_out = tube_char[5];
                3'b110: seg_out = tube_char[6];
                3'b111: seg_out = tube_char[7];
                default:seg_out = 8'b1111_1111;
            endcase
        end
    end
endmodule

module fre_div #(parameter p1 = 200000,
                parameter p2 = 50000000) (
    input clk, rst,
    output clk_m, clk_o
    );
    reg clk_move, clk_out;
    assign clk_m = clk_move;
    assign clk_o = clk_out;
    reg [31:0]cnt1;
    always @(posedge clk, posedge rst) begin
        if(rst) begin
            cnt1 <= 0;
            clk_out <= 0;
        end
        else begin
            if(cnt1 == (p1>>1) - 1)begin
                clk_out <= ~clk_out;
                cnt1 <= 0;
            end
            else begin
                cnt1 <= cnt1 + 1;
            end
        end
    end
    
    reg [31:0] cnt2;
    always @(posedge clk, posedge rst) begin
        if(rst)begin
            cnt2 <= 0;
            clk_move <= 0;
        end
        else begin
            if(cnt2 == (p2>>1) - 1)begin
                clk_move <= ~clk_move;
                cnt2 <= 0;
            end
            else begin
                cnt2 <= cnt2 + 1;
            end
        end 
    end
endmodule