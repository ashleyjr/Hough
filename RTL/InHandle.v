module InHandle(
	input wire			nReset,                                                      // Common to all
	input wire			Clk,                                                        // Common to all
	output reg	[7:0]	Pixel,
	output reg			Frame,
	output reg			Line
);

	parameter COLS = 10;
	parameter ROWS = 10;
	
	reg [7:0] col;
	reg [7:0] row;
	
	always @ (posedge Clk or negedge nReset) begin
		if(nReset) begin  
			Pixel <= 0;
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


			0: Pixel = 162;
			1: Pixel = 112;
			2: Pixel = 120;
			3: Pixel = 132;
			4: Pixel = 135;
			5: Pixel = 120;
			6: Pixel = 133;
			7: Pixel = 165;
			8: Pixel = 157;
			9: Pixel = 83;
			10: Pixel = 138;
			11: Pixel = 109;
			12: Pixel = 113;
			13: Pixel = 124;
			14: Pixel = 167;
			15: Pixel = 171;
			16: Pixel = 120;
			17: Pixel = 136;
			18: Pixel = 114;
			19: Pixel = 58;
			20: Pixel = 123;
			21: Pixel = 112;
			22: Pixel = 113;
			23: Pixel = 127;
			24: Pixel = 178;
			25: Pixel = 202;
			26: Pixel = 167;
			27: Pixel = 165;
			28: Pixel = 78;
			29: Pixel = 128;
			30: Pixel = 133;
			31: Pixel = 110;
			32: Pixel = 131;
			33: Pixel = 134;
			34: Pixel = 109;
			35: Pixel = 144;
			36: Pixel = 195;
			37: Pixel = 137;
			38: Pixel = 99;
			39: Pixel = 167;
			40: Pixel = 131;
			41: Pixel = 112;
			42: Pixel = 123;
			43: Pixel = 78;
			44: Pixel = 80;
			45: Pixel = 164;
			46: Pixel = 154;
			47: Pixel = 53;
			48: Pixel = 136;
			49: Pixel = 157;
			50: Pixel = 120;
			51: Pixel = 124;
			52: Pixel = 83;
			53: Pixel = 67;
			54: Pixel = 133;
			55: Pixel = 153;
			56: Pixel = 122;
			57: Pixel = 80;
			58: Pixel = 151;
			59: Pixel = 161;
			60: Pixel = 116;
			61: Pixel = 116;
			62: Pixel = 82;
			63: Pixel = 88;
			64: Pixel = 106;
			65: Pixel = 158;
			66: Pixel = 96;
			67: Pixel = 109;
			68: Pixel = 158;
			69: Pixel = 208;
			70: Pixel = 120;
			71: Pixel = 103;
			72: Pixel = 96;
			73: Pixel = 75;
			74: Pixel = 69;
			75: Pixel = 150;
			76: Pixel = 93;
			77: Pixel = 110;
			78: Pixel = 158;
			79: Pixel = 174;
			80: Pixel = 133;
			81: Pixel = 90;
			82: Pixel = 66;
			83: Pixel = 81;
			84: Pixel = 87;
			85: Pixel = 150;
			86: Pixel = 186;
			87: Pixel = 128;
			88: Pixel = 159;
			89: Pixel = 106;
			90: Pixel = 140;
			91: Pixel = 89;
			92: Pixel = 60;
			93: Pixel = 71;
			94: Pixel = 119;
			95: Pixel = 139;
			96: Pixel = 180;
			97: Pixel = 143;
			98: Pixel = 111;
			99: Pixel = 87;
		endcase
	end
endmodule
