module Circle(
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

	// Coordinates
	reg	[7:0]	x;
	reg	[7:0] 	y;

	
	always @ (posedge Clk  or negedge nReset) begin
		if(!nReset) begin
			x <= 0;
			y <= 0;
		end else begin
			if(FrameIn) begin
				x <= 1;
				y <= 0;
			end else begin
				if(LineIn) begin
					x <= 1;	
					y = y + 1;
				end else begin
					x <= x + 1;
				end
				if((x == Width-1) && (y == Height-1)) begin
					x <= 0;
					y <= 0;
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

			//if(x == y ) begin
			//	PixelOut <= 8'hFF;
			//end else begin
			//	PixelOut <= PixelIn;
			//end

			if(PixelIn > 10)
				PixelOut <= 250;
			else
				PixelOut <= 10;
			//PixelOut <= PixelIn;
			FrameOut <= FrameIn;
	    	LineOut <= LineIn;

		
		end
	end


endmodule
