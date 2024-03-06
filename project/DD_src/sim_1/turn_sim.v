`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2021/12/31 13:35:56
// Design Name: 
// Module Name: turn_sim
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


module turn_sim();
reg clk,rst;
reg [3:0]n;
wire num,n1,n2,n3,show1,show2,show3;
turn t(clk,rst,n,num,n1,n2,n3,show1,show2,show3);
initial {n,rst,clk}=3'b010;
initial
begin 
    repeat(3)begin
    #10 clk=1'b0;
    #10 clk=1'b1;
       n=n+1;
    end
    
end
    
    
endmodule
