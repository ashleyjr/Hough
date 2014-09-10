module InHandle(
	input wire			nReset,                                                      // Common to all
	input wire			Clk,                                                        // Common to all
	output reg	[7:0]	Pixel,
	output reg			Frame,
	output reg			Line
);


always @ (posedge Clk or negedge nReset) begin
	if(!nReset) begin   
    	Pixel <= 8'h00;   
		Frame <= 0;
    	Line  <= 0;
	end else begin
		Pixel <= 8'hAA;   
		Frame <= 1;
    	Line  <= 1;
    end
end


endmodule

