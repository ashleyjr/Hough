`timescale 1ns/1ns

module TB;
    


   parameter CLK_PERIOD = 10;          // 100MHz clock - 10ns period  

   reg                        nReset;
   reg                        Clk;
   wire [7:0]                       Pixel;
   wire                        Frame;
   wire	                      Line;

   integer count;
   integer file;


	InHandle InHandle(
		.nReset     (nReset),
		.Clk       	(Clk),
		.Pixel		(Pixel),
		.Frame		(Frame),
		.Line		(Line)
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
        $fwrite(file,"Test\n");
		
		count = 0;
		while(count < 2) begin
			@ (posedge Clk) begin
				if(Frame) begin 
					$fwrite(file,"%d",Pixel);
					count = count + 1;
				end else begin
					if(Line)
						$fwrite(file,",%d\n",Pixel);
					else
						$fwrite(file,",%d",Pixel);
				end
			end
		end
        $fclose(file);

	end





endmodule

