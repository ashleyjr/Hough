module Line(
	input wire			nReset,                                                      // Common to all
	input wire			Clk,     
	input wire 	[7:0]	PixelIn,
	input wire			FrameIn,
	input wire			LineIn,
	input wire	[7:0]	m,
	input wire	[7:0]	c,
	output reg	[7:0]	PixelOut,
	output reg			FrameOut,
	output reg			LineOut
);

	// Coordinates
	reg	[7:0]	x;
	reg	[7:0] 	y;
	
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
	    	LineOut  <= 0;		
		
		end else begin
			
			// TODO: You can't draw a line like this, no vertical!

			// Draw a line	
			if(y == (m*x) + c) begin
				PixelOut <= 8'hFF;
			end else begin
				PixelOut <= PixelIn;
			end
			FrameOut <= FrameIn;
	    	LineOut <= LineIn;

		
		end
	end


endmodule
