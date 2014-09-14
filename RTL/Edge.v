module Edge(
	input wire			nReset,                                                      // Common to all
	input wire			Clk,     
	input wire 	[7:0]	PixelIn,
	input wire			FrameIn,
	input wire			LineIn,
	input wire	[7:0]	Width,
	output reg	[7:0]	PixelOut,
	output reg			FrameOut,
	output reg			LineOut
);

	// Buffer must be equal to or larger than the width of the image
	parameter BUFF = 50;
	// Operation buffer for control signals
	parameter EXTRA = 1;

	// Buffer
	reg [7:0] 	pixelDelay	[BUFF:0];
   	reg 		frameDelay	[BUFF+EXTRA:0];
	reg 		lineDelay	[BUFF+EXTRA:0];

	// Edge
	reg [8:0]		horz;
	reg [8:0]		vert;

	
	// Pipe for pixels and extra for control lines 
	generate
		genvar j;
		for (j=0; j < BUFF; j = j + 1) begin : delay_pixel
	    	always @(posedge Clk) begin
				pixelDelay[j+1] <= 	pixelDelay[j];
	        end
	    end
		for (j=0; j < BUFF+EXTRA; j = j + 1) begin : delay_control
	    	always @(posedge Clk) begin
				frameDelay[j+1] <= frameDelay[j];
				lineDelay[j+1] <= lineDelay[j];
	        end
	    end
	endgenerate

	
	always @ (posedge Clk or negedge nReset) begin
		if(!nReset) begin   
			PixelOut <= 0;
			FrameOut <= 0;
	    	LineOut  <= 0;		
		end else begin
			// In
			pixelDelay[0] <= PixelIn;
	        frameDelay[0] <= FrameIn;
			lineDelay[0] <= LineIn;		
			// Difference the vertical and horizontal pixels
			if(pixelDelay[BUFF] > pixelDelay[BUFF-1])  	horz <= pixelDelay[BUFF] - pixelDelay[BUFF-1]; 
			else										horz <= pixelDelay[BUFF-1] - pixelDelay[BUFF]; 
	
			if(pixelDelay[BUFF] > pixelDelay[BUFF-Width])  	vert <= pixelDelay[BUFF] - pixelDelay[BUFF-Width]; 
			else											vert <= pixelDelay[BUFF-Width] - pixelDelay[BUFF]; 	
			// Out
			PixelOut <= (horz + vert) >> 1;	// Divide by 2 as sum of two bytes	
			FrameOut <= frameDelay[BUFF+EXTRA];
	    	LineOut  <= lineDelay[BUFF+EXTRA];			
		end
	end


endmodule
