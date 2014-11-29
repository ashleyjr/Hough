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
		
	reg [7:0]	x;
	reg [7:0]	y;

	reg [7:0]	BuffPixel;
	reg			BuffFrame;
	reg			BuffLine;
		
	always @ (posedge Clk  or negedge nReset) begin
		if(!nReset) begin
			x <= 0;
			y <= 0;
		end else begin
			if(FrameIn) begin
				x <= 0;
				y <= 0;
			end else begin
				if(LineIn) begin
					x <= 0;	
					y <= y + 1;
				end else begin
					x <= x + 1;
				end
			end
		end
	end


	always @ (posedge Clk or negedge nReset) begin
		if(!nReset) begin
			PixelOut <= 0;
			FrameOut <= 0;
			LineOut <= 0;		
		end else begin		
			// Buffer to sync up coordinates	
			BuffPixel <= PixelIn;
			BuffFrame <= FrameIn;
			BuffLine <= LineIn;

			// Put remove pixel that are nonsense
			if(	(x > Width-3) | (y > Height-3))		
				PixelOut <= 8'h00;
			else 									
				PixelOut <= BuffPixel;
			FrameOut <= BuffFrame;
			LineOut <= BuffLine;	
		end
	end
endmodule
