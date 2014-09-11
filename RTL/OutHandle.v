module OutHandle(                                                  // Common to all
	input wire			nReset,   
	input wire			Clk,                                                        // Common to all
	input wire	[7:0]	Pixel,
	input wire			Frame,
	input wire			Line,
	output reg	[7:0]	data,
	output reg	[7:0]	i,
	output reg	[7:0] 	j
);
	
	reg [7:0] col;
	reg [7:0] row;
	
	always @ (posedge Clk or negedge nReset) begin
		if(nReset) begin
			i <= 0;
			j <= 0;
			data <= 0;
		end else begin
			data <= Pixel;
			if(Frame) begin
				i <= 0;
				j <= 0;
			end else begin	
				if(Line) begin
					i <= 0;
					j <= j + 1;
				end else begin
					i <= i + 1;
				end
			end
		end
	
	end

endmodule
