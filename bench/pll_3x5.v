module pll_3x5 (
	input	inclk0,	
	output	reg c0,
	output	reg c1,	
	output	reg locked
);

initial	begin
	c0 = 0;
	c1 = 0;
	locked = 0;
end

always	#10000	c0 <= ~c0;
always	#2381 	c1 <= ~c1;

always	@(posedge c0) locked <= 1;

endmodule
