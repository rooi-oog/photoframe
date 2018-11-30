module pll_x1 (
	input	inclk0,
	input	areset,
	output	reg c0,
	output	reg c1,
	output	reg c2,
	output	reg locked	
);

initial begin
	c0 = 0;
	c1 = 0;
	c2 = 0;
	locked = 0;
end

always	#5000	c0 <= ~c0;
always	#3571 	c1 <= ~c1;
always	#10000	c2 <= ~c2;

always	@(posedge c0) locked <= 1;


endmodule
