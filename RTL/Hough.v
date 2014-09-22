module Hough(
	input wire			nReset,                                                      // Common to all
	input wire			Clk,     
	input wire 	[7:0]	PixelIn,
	input wire			FrameIn,
	input wire			LineIn,
	output wire	[7:0]	PixelOut,		// Output wires as registeres in submodules
	output wire			FrameOut,
	output wire			LineOut
);
	
	wire	[7:0]			HeightOut;
	wire	[7:0]			WidthOut;

	wire	[7:0]			PixelEd2Ci;
	wire					FrameEd2Ci;
	wire					LineEd2Ci;

	Edge Edge(
		.nReset     (nReset),
		.Clk       	(Clk),
		.PixelIn	(PixelIn),
		.FrameIn	(FrameIn),
		.LineIn		(LineIn),
		.Width		(WidthOut),
		.PixelOut	(PixelEd2Ci),
		.FrameOut	(FrameEd2Ci),
		.LineOut	(LineEd2Ci)
	);

	Width Width(
		.nReset     (nReset),
		.Clk       	(Clk),
		.Line		(LineIn),
		.Width		(WidthOut)
	);

	Height Height(
		.nReset     (nReset),
		.Clk       	(Clk),
		.Line		(LineIn),
		.Frame		(FrameIn),
		.Height		(HeightOut)
	);

	Circle Circle(
		.nReset     (nReset),
		.Clk       	(Clk),
		.PixelIn	(PixelEd2Ci),
		.FrameIn	(FrameEd2Ci),
		.LineIn		(LineEd2Ci),
		.Width		(WidthOut),
		.Height		(HeightOut),
		.PixelOut	(PixelOut),
		.FrameOut	(FrameOut),
		.LineOut	(LineOut)
	);
	

endmodule

