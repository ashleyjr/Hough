module Resize(
	input wire			nReset,                                                      // Common to all
	input wire			Clk,     
	input wire 	[7:0]	PixelIn,
	input wire			FrameIn,
	input wire			LineIn,
	input wire	[7:0]	Width,
	input wire	[7:0]	Height,
	output reg	[7:0]	PixelOut,
	output reg			FrameOut,
	output reg			LineOut
);
		
	`define	PASS	1'b0
	`define BLACK_1	1'b1	
	
	reg 		black;
	reg [7:0]	countHeight;
	reg [7:0]	countWidth;

	always @ (posedge Clk or negedge nReset) begin
		if(!nReset) begin
			FrameOut <= 0;
			LineOut <= 0;
			black <= `BLACK_1;
			countHeight <= 0;
			countWidth <= 0;
		end else begin
			
			if(black == `PASS) begin
				PixelOut <= PixelIn;	
			end else begin
				PixelOut <= 8'hFF;
			end
			LineOut <= LineIn;
			FrameOut <= FrameIn;
		
			
			//if(LineIn) 			black <= `BLACK_2;
			//if(black == `BLACK_2)	black <= `PASS;

			//if(count == (Width-1)) 	PixelOut <= 8'hFF;
			//else					PixelOut <= PixelIn;
		
			//if(count == Width)	count <= 0;
			//else				count <= count + 1;
		
			if(FrameIn)	begin
				black <= `BLACK_1;
				countHeight <= 0;
			end else begin
				if(LineIn) begin
					if(countHeight == (Height-2)) begin
						black <= `BLACK_1;
						countHeight <= 0;
					end else begin
						black <= `PASS;
						countWidth <= 0;
						countHeight <= countHeight + 1;
					end
				end else begin
					countWidth <= countWidth + 1;	
					if(countWidth == (Width-3)) begin
						black <= `BLACK_1;
					end 
				end
			end

		end
	end
endmodule
