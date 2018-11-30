module wb_ram #(
	parameter ADDR_WIDTH = 12
)
(
	input			wb_clk_i,
	input			wb_rst_i,
	input	[31:0]	wb_adr_i,
	input	[31:0]	wb_dat_i,
	output	[31:0]	wb_dat_o,
	input	[ 3:0]	wb_sel_i,
	input	[ 2:0]	wb_cti_i,
	input	[ 1:0]	wb_bte_i,
	input			wb_cyc_i,
	input			wb_stb_i,
	input			wb_we_i,
	output reg		wb_ack_o
);

	wire wb_acc = wb_stb_i & wb_cyc_i;
	
	// Variable to hold the registered read address
	reg [ADDR_WIDTH - 1: 0] addr_reg;
	
	// Declare the RAM variable
	reg [7:0] ram0 [2047:0]; //[2**ADDR_WIDTH - 1: 0];
	reg [7:0] ram1 [2047:0]; //[2**ADDR_WIDTH - 1: 0];
	reg [7:0] ram2 [2047:0]; //[2**ADDR_WIDTH - 1: 0];
	reg [7:0] ram3 [2047:0]; //[2**ADDR_WIDTH - 1: 0];

	always @ (posedge wb_clk_i)	begin
		if (wb_acc & wb_we_i) begin
			if (wb_sel_i [0])
				ram0 [wb_adr_i [27: 2]] <= wb_dat_i [7:0];
			if (wb_sel_i [1])
				ram1 [wb_adr_i [27: 2]] <= wb_dat_i [15:8];
			if (wb_sel_i [2])
				ram2 [wb_adr_i [27: 2]] <= wb_dat_i [23:16];
			if (wb_sel_i [3])
				ram3 [wb_adr_i [27: 2]] <= wb_dat_i [31:24];
		end
		
		if (wb_acc)
			addr_reg <= wb_adr_i [27: 2];		
	end

	// Continuous assignment implies read returns NEW data.
	// This is the natural behavior of the TriMatrix memory
	// blocks in Single Port mode.  
	assign wb_dat_o = {ram3 [addr_reg], ram2 [addr_reg], ram1 [addr_reg], ram0 [addr_reg]};

	always	@(posedge wb_clk_i)
		wb_ack_o <= wb_acc & ~wb_ack_o;
endmodule
