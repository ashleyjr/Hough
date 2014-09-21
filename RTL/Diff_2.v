module Diff_2(     
	input wire 	[7:0]	In1,
	input wire 	[7:0]	In2,
	output wire	[8:0]	Out
);
	always @(*) 
		if (In1 > In2 )
			Out = (In1<<1) - (In2<<1);
		else
			Out = (In2<<1) - (In1<<1);	
endmodule
