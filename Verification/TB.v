`timescale 1ns/1ns

module TB;
    


   parameter CLK_PERIOD = 10;          // 100MHz clock - 10ns period  

   	reg                  	nReset;
   	reg                   	Clk;
   
   	wire 	[7:0]        	PixelIn2Ed;
   	wire                   	FrameIn2Ed;
   	wire	            	LineIn2Ed;

	wire 	[7:0]           PixelEd2Out;
   	wire                  	FrameEd2Out;
   	wire	               	LineEd2Out;


   	wire	[7:0] 			data;
	wire 	[7:0] 			i;
	wire 	[7:0] 			j;
	wire					FrameOut;

	integer frames;
   	integer file;


	InHandle InHandle(
		.nReset     (nReset),
		.Clk       	(Clk),
		.Pixel		(PixelIn2Ed),
		.Frame		(FrameIn2Ed),
		.Line		(LineIn2Ed)
	);

	Edge Edge(
		.nReset     (nReset),
		.Clk       	(Clk),
		.PixelIn	(PixelIn2Ed),
		.FrameIn	(FrameIn2Ed),
		.LineIn		(LineIn2Ed),
		.PixelOut	(PixelEd2Out),
		.FrameOut	(FrameEd2Out),
		.LineOut	(LineEd2Out)
	);
  
	OutHandle OutHandle(
		.nReset     (nReset),
		.Clk       	(Clk),
		.Pixel		(PixelEd2Out),
		.Frame		(FrameEd2Out),
		.Line		(LineEd2Out),
		.FrameOut	(FrameOut),
		.data		(data),
		.i			(i),
		.j 			(j)
	);
  


	initial begin
		while(1) begin
			#(CLK_PERIOD/2) Clk = 0;
			#(CLK_PERIOD/2) Clk = 1;
		end
	end

   	initial begin
		#100 nReset = 0;
		#100 nReset = 1;

		file = $fopen("../Verification/OutIm.dat","w");  
		
		frames = 0;
		while(frames < 2) begin
			@(posedge Clk) begin
				if(FrameOut) begin 
					frames = frames + 1;
					$fwrite(file,"%d,%d,%d\n",j,i,data);
				end else begin
					if(frames == 1) begin
						$fwrite(file,"%d,%d,%d\n",j,i,data);
					end
				end
			end
		end
		$fwrite(file,"%d,%d,%d",j,i,data);
        $fclose(file);

	end





endmodule

