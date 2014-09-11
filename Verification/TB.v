`timescale 1ns/1ns

module TB;
    


   parameter CLK_PERIOD = 10;          // 100MHz clock - 10ns period  

   reg                        nReset;
   reg                        Clk;
   wire [7:0]                       Pixel;
   wire                        Frame;
   wire	                      Line;

   wire	[7:0] data;
	wire [7:0] i;
	wire [7:0] j;

   integer count;
   integer file;


	InHandle InHandle(
		.nReset     (nReset),
		.Clk       	(Clk),
		.Pixel		(Pixel),
		.Frame		(Frame),
		.Line		(Line)
	);
  
	OutHandle OutHandle(
		.nReset     (nReset),
		.Clk       	(Clk),
		.Pixel		(Pixel),
		.Frame		(Frame),
		.Line		(Line),
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
		#100 nReset = 1;
		#100 nReset = 0;

		file = $fopen("OutIm.dat","w");  
		
		count = 0;
		while(count < 500) begin
			@(posedge Clk) $fwrite(file,"%d,%d,%d\n",i,j,data);
			count = count + 1;
		end
		@(posedge Clk) $fwrite(file,"%d,%d,%d",i,j,data);
        $fclose(file);

	end





endmodule

