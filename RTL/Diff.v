module Diff(     
	input wire 	[7:0]	In1,
	input wire 	[7:0]	In2,
	output wire	[7:0]	Out
);
	always @(*) 
		if (In1 > In2 )
			Out = In1 - In2;
		else
			Out = In2 - In1;
endmodule
