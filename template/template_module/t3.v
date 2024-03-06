`timescale 1ns / 1ps

module t3 (
    input clk,
 	input rst_n,
 	input sw,
	output [7:0] position,
 	output [7:0] tube_out
    );
	
	wire clk_out;
 	 	
 	clk_div cd(
 		.clk( clk ),
 		.rst( rst_n ),
 		.clk_out( clk_out )
 	);
 	tube t(
 		.clk( clk ),
 		.rst( rst_n ),
 		.sw( sw ),
		.posi( position ),
 		.clk_out( clk_out ),
 		.tube( tube_out )
 	);
    
endmodule


module tube(
 	input clk,
 	input rst,
 	input sw,
 	input clk_out,
	output reg [7:0] posi,
 	output reg [7:0] tube
 	);
	reg [2:0] scan_cnt;
	
	always @(posedge clk, negedge rst) begin
		if(!rst)
			scan_cnt <= 0;
		else begin
			scan_cnt <= scan_cnt + 1'b1;
			if(scan_cnt == 3'b111) scan_cnt <= 3'b000;
		end
	end

	always @(scan_cnt) begin
		case(scan_cnt)
			3'b000: posi = 8'b11111110;
			3'b001: posi = 8'b11111101;
			3'b010: posi = 8'b11111011;
			3'b011: posi = 8'b11110111;
			3'b100: posi = 8'b11101111;
			3'b101: posi = 8'b11011111;
			3'b110: posi = 8'b10111111;
			3'b111: posi = 8'b01111111;
			default: posi = 8'b11111111;
		endcase
	end

	always @(scan_cnt) begin
		if(sw)
			case(scan_cnt)
			3'b000: tube = 8'b11111000; //7
			3'b001: tube = 8'b11000000; //0
			3'b010: tube = 8'b10100100; //2
			3'b011: tube = 8'b10110110; //s
			3'b100: tube = 8'b11000110; //c
			default: tube = 8'b11111111;
			endcase
		else
			case(scan_cnt)
			3'b000: tube = 8'b10001110; //F
			3'b001: tube = 8'b11111001; //1
			3'b010: tube = 8'b10100100; //2
			3'b011: tube = 8'b11000000; //0
			3'b100: tube = 8'b10100100; //2
			default: tube = 8'b11111111;
			endcase
	end
		
endmodule

module clk_div(
    input clk,
 	input rst,
 	output reg clk_out
 	);	
	parameter period = 200000;
	reg [3:0] cnt;
 	always @ (posedge clk, negedge rst) begin
		if (~rst) begin
			cnt <= 0;
			clk_out <= 0;	 
		end
		else begin
			if(cnt == (period>>1)-1) begin
				clk_out <= ~clk_out;
				cnt <= 0;
			end
			else begin
				cnt <= cnt+1;
			end
		end
	end
endmodule
