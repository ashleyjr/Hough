module Edge(
	input wire			nReset,                                                      // Common to all
	input wire			Clk,     
	input wire 	[7:0]	PixelIn,
	input wire			FrameIn,
	input wire			LineIn,
	output reg	[7:0]	PixelOut,
	output reg			FrameOut,
	output reg			LineOut
);

	parameter BUFF = 400;
	parameter EXTRA = 2;

	reg [7:0]	width;
	reg [7:0]	count;

	reg [7:0] 	pixelDelay	[BUFF:0];
   	reg 		frameDelay	[BUFF+EXTRA:0];
	reg 		lineDelay	[BUFF+EXTRA:0];

	 reg [15:0]		top_horz;
	 reg [15:0]		mid_horz;
	 reg [15:0] 	bot_horz;
	
	reg [15:0]		top_vert;
	 reg [15:0]		mid_vert;
	 reg [15:0] 	bot_vert;

	 reg [15:0]		sum;


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


	// Find out the lenth of a line in the image
	always @ (posedge Clk or negedge nReset) begin
		if(!nReset) begin  
			count <= 0;
			width <= 0;
		end else begin
			if(LineOut) begin
				count <= 0;
				width <= count + 1;
			end else begin
				count <= count + 1;
			end
		end
	end
	

	
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

			
			// Smoothing - Extra 1
			//top <= pixelDelay[BUFF] + pixelDelay[BUFF-1] + pixelDelay[BUFF-2]; 
			//mid <= pixelDelay[BUFF-width] + pixelDelay[BUFF-width-1] + pixelDelay[BUFF-width-2];
			//bot <= pixelDelay[BUFF-width-width] + pixelDelay[BUFF-width-width-1] + pixelDelay[BUFF-width-width-2];
		

			// Sobel - Extra 1
			top_vert <= 8'hFF + pixelDelay[BUFF] - pixelDelay[BUFF-2]; 
			mid_vert <= 8'hFF + pixelDelay[BUFF-width] - pixelDelay[BUFF-width-2];
			bot_vert <= 8'hFF + pixelDelay[BUFF-width-width] - pixelDelay[BUFF-width-width-2];
	
			top_horz <= 8'hFF + pixelDelay[BUFF] - pixelDelay[BUFF-width-width]; 
			mid_horz <= 8'hFF + pixelDelay[BUFF-1] - pixelDelay[BUFF-width-width-1];
			bot_horz <= 8'hFF + pixelDelay[BUFF-2] - pixelDelay[BUFF-width-width-2];


			// Extra 2
			sum <= (top_horz + (mid_horz << 1) + bot_horz) + (top_vert + (mid_vert << 1) + bot_vert);
			

			PixelOut <= sum >> 4;

			FrameOut <= frameDelay[BUFF+EXTRA];
	    	LineOut  <= lineDelay[BUFF+EXTRA];		
		
		end
	end

endmodule
