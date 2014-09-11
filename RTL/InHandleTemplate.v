module InHandle(
	input wire			nReset,                                                      // Common to all
	input wire			Clk,                                                        // Common to all
	output reg	[7:0]	Pixel,
	output reg			Frame,
	output reg			Line
);

	parameter COLS = <COLS>;
	parameter ROWS = <ROWS>;
	
	reg [7:0] col;
	reg [7:0] row;
	
	always @ (posedge Clk or negedge nReset) begin
		if(!nReset) begin   
			Frame <= 0;
	    	Line  <= 0;							
			row <= ROWS-1;
			col <= COLS-1;						// Zero on first pixel	
		end else begin
			if(col == (COLS-1)) begin			// Get ready for next column
	    		Line <= 1;
				col <= 0;
				row <= row + 1;
				if(row == (ROWS-1)) begin		// Get ready for next row
					Frame <= 1;
					row <= 0;
				end
			end else begin
				Line <= 0;
				Frame <= 0;
				col = col + 1;
			end
		end
	end

	always @ (*) begin
		case(col + (row*COLS))

