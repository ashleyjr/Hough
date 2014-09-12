`timescale 1ns/1ns

module TB;
    


   parameter CLK_PERIOD = 5;          // 100MHz clock - 10ns period  

   	reg                  	nReset;
   	reg                   	Clk;
   
   	wire 	[7:0]        	PixelIn2Hough;
   	wire                   	FrameIn2Hough;
   	wire	            	LineIn2Hough;

	wire 	[7:0]           PixelHough2Out;
   	wire                  	FrameHough2Out;
   	wire	               	LineHough2Out;

	wire	[7:0]			HeightOut;
	wire	[7:0]			WidthOut;

   	wire	[7:0] 			data;
	wire 	[7:0] 			i;
	wire 	[7:0] 			j;
	wire					FrameOut;

	integer frames;
   	integer file;
	integer count;


	InHandle InHandle(
		.nReset     (nReset),
		.Clk       	(Clk),
		.Pixel		(PixelIn2Hough),
		.Frame		(FrameIn2Hough),
		.Line		(LineIn2Hough)
	);

	Hough Hough(
		.nReset     (nReset),
		.Clk       	(Clk),
		.PixelIn	(PixelIn2Hough),
		.FrameIn	(FrameIn2Hough),
		.LineIn		(LineIn2Hough),
		.PixelOut	(PixelHough2Out),
		.FrameOut	(FrameHough2Out),
		.LineOut	(LineHough2Out)
	);
  
	OutHandle OutHandle(
		.nReset     (nReset),
		.Clk       	(Clk),
		.Pixel		(PixelHough2Out),
		.Frame		(FrameHough2Out),
		.Line		(LineHough2Out),
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
      $dumpfile("TB.vcd");
      $dumpvars(0,TB);
   end
	
   	initial begin
		#100 nReset = 0;
		#100 nReset = 1;


		file = $fopen("OutIm.dat","w");  
		
		count = 0;
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
				if(LineHough2Out) begin
					count = count + 1;
					$display(count);
				end
			end
		end
		$fwrite(file,"%d,%d,%d",j,i,data);
        //$fclose(file);
	
		$finish;
	end





endmodule

