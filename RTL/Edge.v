module Edge(
	input wire			nReset,                                                      // Common to all
	input wire			Clk,     
	input wire 	[7:0]	PixelIn,
	input wire			FrameIn,
	input wire			LineIn,
	input wire	[7:0]	Width,
	output reg	[10:0]	PixelOut,
	output reg			FrameOut,
	output reg			LineOut
);

	// Buffer must be equal to or larger than the width of the image
	parameter BUFF = 500;
	// Operation buffer for control signals
	parameter EXTRA = 1;

	// Buffer
	reg [7:0] 	pixelDelay	[BUFF:0];
   	reg 		frameDelay	[BUFF+EXTRA:0];
	reg 		lineDelay	[BUFF+EXTRA:0];

	// Edge
	reg [7:0]		horz_bottom;
	reg [8:0]		horz_middle;
	reg [7:0]		horz_top;
	
	reg [7:0]		vert_left;
	reg [8:0]		vert_middle;
	reg [7:0]		vert_right;

	wire [8:0]		Width2;

	
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

	assign Width2 = Width << 1;

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
			
		
			// horz
			if(pixelDelay[BUFF] > pixelDelay[BUFF-2])  					horz_bottom <= pixelDelay[BUFF] - pixelDelay[BUFF-2]; 
			else														horz_bottom <= pixelDelay[BUFF-2] - pixelDelay[BUFF]; 

			if(pixelDelay[BUFF-Width] > pixelDelay[BUFF-Width-2])  		horz_middle <= (pixelDelay[BUFF-Width] - pixelDelay[BUFF-Width-2]) << 1; 
			else														horz_middle <= (pixelDelay[BUFF-Width-2] - pixelDelay[BUFF-Width]) << 1; 
	
			if(pixelDelay[BUFF-Width2] > pixelDelay[BUFF-Width2-2])  	horz_top <= pixelDelay[BUFF-Width2] - pixelDelay[BUFF-Width2-2]; 
			else														horz_top <= pixelDelay[BUFF-Width2-2] - pixelDelay[BUFF-Width2]; 
	

			// vert
			if(pixelDelay[BUFF] > pixelDelay[BUFF-Width2])  			vert_right <= pixelDelay[BUFF] - pixelDelay[BUFF-Width2]; 
			else														vert_right <= pixelDelay[BUFF-Width2] - pixelDelay[BUFF]; 
	
			if(pixelDelay[BUFF-1] > pixelDelay[BUFF-Width2-1])  		vert_middle <= (pixelDelay[BUFF-1] - pixelDelay[BUFF-Width2-1]) << 1; 
			else														vert_middle <= (pixelDelay[BUFF-Width2-1] - pixelDelay[BUFF-1]) << 1; 
	
			if(pixelDelay[BUFF-2] > pixelDelay[BUFF-Width2-2])  		vert_left <= pixelDelay[BUFF-2] - pixelDelay[BUFF-Width2-2]; 
			else														vert_left <= pixelDelay[BUFF-Width2-2] - pixelDelay[BUFF-2]; 
	

						
			
			// Out
			PixelOut <= horz_bottom + horz_middle + horz_top + vert_left + vert_middle + vert_right;
			FrameOut <= frameDelay[BUFF+EXTRA];
	    	LineOut  <= lineDelay[BUFF+EXTRA];			
		end
	end


endmodule
