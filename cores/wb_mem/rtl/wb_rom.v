module wb_rom (
	input				wb_clk_i,
	input				wb_rst_i,
	input		[31:0]	wb_adr_i,
	input		[31:0]	wb_dat_i,
	output	reg [31:0]	wb_dat_o,
	input		[ 3:0]	wb_sel_i,
	input		[ 2:0]	wb_cti_i,
	input		[ 1:0]	wb_bte_i,
	input				wb_cyc_i,
	input				wb_stb_i,
	input				wb_we_i,
	output reg			wb_ack_o
);

	wire wb_acc = wb_stb_i & wb_cyc_i;

	reg [31:0] rom [3071 :0];
	
	`ifndef SIMULATION
	initial
		$readmemh ("bios.hex", rom);
	`endif
	
	always	@(posedge wb_clk_i)
		wb_ack_o <= wb_acc & ~wb_ack_o;
		
	always	@(posedge wb_clk_i or posedge wb_rst_i)
		if (wb_rst_i)
			wb_dat_o <= 'd0;
		else if (wb_acc)
			wb_dat_o <= rom [wb_adr_i [31:2]];

endmodule
