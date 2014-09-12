module Width(
	input wire			nReset,                                                      // Common to all
	input wire			Clk,     
	input wire			Line,
	output reg	[7:0]	Width
);

	// Control
	reg [7:0]	count;

	// Find out the lenth of a line in the image
	always @ (posedge Clk or negedge nReset) begin
		if(!nReset) begin  
			count <= 0;
			Width <= 0;
		end else begin
			if(Line) begin
				count <= 0;
				Width <= count + 1;
			end else begin
				count <= count + 1;
			end
		end
	end
	
endmodule
