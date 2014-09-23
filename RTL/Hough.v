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

	wire	[7:0]			PixelEd2Re;
	wire					FrameEd2Re;
	wire					LineEd2Re;

	wire	[7:0]			PixelRe2Ci;
	wire					FrameRe2Ci;
	wire					LineRe2Ci;



	Edge Edge(
		.nReset     (nReset),
		.Clk       	(Clk),
		.PixelIn	(PixelIn),
		.FrameIn	(FrameIn),
		.LineIn		(LineIn),
		.Width		(WidthOut),
		.PixelOut	(PixelEd2Re),
		.FrameOut	(FrameEd2Re),
		.LineOut	(LineEd2Re)
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

	Resize Resize(
		.nReset     (nReset),
		.Clk       	(Clk),
		.PixelIn	(PixelEd2Re),
		.FrameIn	(FrameEd2Re),
		.LineIn		(LineEd2Re),
		.Width		(WidthOut),
		.Height		(HeightOut),
		.PixelOut	(PixelRe2Ci),
		.FrameOut	(FrameRe2Ci),
		.LineOut	(LineRe2Ci)
	
	);
	
	Circle Circle(
		.nReset     (nReset),
		.Clk       	(Clk),
		.PixelIn	(PixelRe2Ci),
		.FrameIn	(FrameRe2Ci),
		.LineIn		(LineRe2Ci),
		.Width		(WidthOut),
		.Height		(HeightOut),
		.PixelOut	(PixelOut),
		.FrameOut	(FrameOut),
		.LineOut	(LineOut)
	);
	

endmodule

