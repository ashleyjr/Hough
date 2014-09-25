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

	wire	[7:0]			PixelRe2Li;
	wire					FrameRe2Li;
	wire					LineRe2Li;



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
		.PixelOut	(PixelRe2Li),
		.FrameOut	(FrameRe2Li),
		.LineOut	(LineRe2Li)
	
	);
	
	Line Line(
		.nReset     (nReset),
		.Clk       	(Clk),
		.PixelIn	(PixelRe2Li),
		.FrameIn	(FrameRe2Li),
		.LineIn		(LineRe2Li),
		.m			(8'h01),
		.c			(8'h00),
		.PixelOut	(PixelOut),
		.FrameOut	(FrameOut),
		.LineOut	(LineOut)
	);
	

endmodule

