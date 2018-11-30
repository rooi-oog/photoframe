module simple_dual_ram #(
	parameter DATA_WIDTH = 8, 
	parameter ADDR_WIDTH = 6
)(
	input [(DATA_WIDTH - 1): 0] data,
	input [(ADDR_WIDTH - 1): 0] read_addr, write_addr,
	input we, read_clock, write_clock,
	output reg [(DATA_WIDTH - 1): 0] q
);	
	reg [DATA_WIDTH - 1: 0] ram [2**ADDR_WIDTH - 1: 0];
	
	always @ (posedge write_clock) begin		
		if (we) ram [write_addr] <= data;
	end
	
	always @ (posedge read_clock) begin		
		q <= ram [read_addr];
	end
	
endmodule
