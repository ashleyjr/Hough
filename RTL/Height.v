module Height(
	input wire			nReset,                                                      // Common to all
	input wire			Clk,     
	input wire			Frame,
	input wire			Line,
	output reg	[7:0]	Height
);

	// Control
	reg [7:0]	count;

	// Find out the lenth of a line in the image
	always @ (posedge Clk or negedge nReset) begin
		if(!nReset) begin  
			count <= 0;
			Height <= 0;
		end else begin
			if(Line) begin
				if(Frame) begin	
					count <= 0;
					Height <= count + 1;
				end else begin
					count <= count + 1;
				end
			end
		end
	end


endmodule
