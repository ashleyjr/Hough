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


	reg [7:0] pixelDelay[7:0];
   	reg [7:0] frameDelay;
	reg [7:0] lineDelay;


	generate
	   genvar j;
	   for (j=0; j < 7; j = j + 1) 
	      begin : delay_stages
	         always @(posedge Clk)
	         begin
	            pixelDelay[j+1] <= pixelDelay[j];
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
			pixelDelay[0] <= PixelIn >> 1;
	        frameDelay[0] <= FrameIn;
			lineDelay[0] <= LineIn;

			PixelOut <= pixelDelay[7];
			FrameOut <= frameDelay[7];
	    	LineOut  <= lineDelay[7];		
		
		end
	end

endmodule
