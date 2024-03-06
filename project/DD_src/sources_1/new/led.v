`timescale 1ns / 1ps

module led (
    input clk,
 	input st,
 	output [23:0] led,
 	output time_end
    );
	
	wire clk_bps;
 	 	
 	counter c(
 		.clk( clk ),
 		.rst( st ),
 		.clk_bps( clk_bps )
 	);
 	flash fl(
 		.clk( clk ),
 		.rst( st ),
 		.clk_bps( clk_bps ),
 		.led( led ),
 		.time_end(time_end)
 	);
endmodule


module flash(
 	 	input clk,
 	 	input rst,
 	 	input clk_bps,
 	 	output reg[23:0]led,
 	 	output reg time_end
 	 	);
		always @( posedge clk, negedge rst )
 	 		if( ~rst ) begin
 	 			led = 24'd1;
 	 			time_end = 0;
 	 	    end
 	 		else if( clk_bps && rst) begin
 	 		   if( led != 24'h0 ) begin
 	 		       led = led << 1'b1;
 	 		   end
 	 		   else time_end = 1;
 	 		end
endmodule

module counter(
        input clk,
 	 	input rst,
 	 	output clk_bps
 	 	);	
 	 	reg [13:0]cnt_first,cnt_second;
 	 	always @( posedge clk, negedge rst )
 	 	 	if( ~rst )
 	 			cnt_first <= 14'd0;
 	 		else if( cnt_first == 14'd10000 )
 	 			cnt_first <= 14'd0;
 	 		else
 	 			cnt_first <= cnt_first + 1'b1;
 	 	always @( posedge clk, negedge rst )
 	 		if( ~rst )
 	 			cnt_second <= 14'd0;
 	 		else if( cnt_second == 14'd10000 )
 	 			cnt_second <= 14'd0;
 	 		else if( cnt_first == 14'd10000 )
 	 			cnt_second <= cnt_second + 1'b1;
 	 	assign clk_bps = cnt_second == 14'd10000 ? 1'b1 : 1'b0;
endmodule