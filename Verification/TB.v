`timescale 1ns/1ns

module TB;
    


   parameter CLK_PERIOD = 10;          // 100MHz clock - 10ns period  

   reg                        nReset;
   reg                        Clk;
   reg                        Pixel;
   reg                        Frame;
   reg	                      Line;



	InHandle 
	#()
	InHandle(
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





endmodule

