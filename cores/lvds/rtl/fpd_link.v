module fpd_link #(
	parameter csr_addr = 4'h0,
	parameter TECHNOLOGY = "GENERIC_LVDS"
) (
	input			sys_clk,
	input			sys_rst,
	input			pixel_clk,
	input			serial_clk,
	
	input	[13:0]	csr_a,
	input	[31:0]	csr_di,
	output	[31:0]	csr_do,
	input			csr_we,

	output			clk,
	output			rx0,
	output			rx1,
	output			rx2,
	output			rx3,
			
	output	[31:0]	wb_adr_o,
	input	[31:0]	wb_dat_i,
	output	[31:0]	wb_dat_o,
	output	[ 3:0]	wb_sel_o,
	output	[ 2:0]	wb_cti_o,
	output	[ 1:0]	wb_bte_o,
	output			wb_cyc_o,
	output			wb_stb_o,
	output			wb_we_o,
	input			wb_ack_i
);
/*------------------------------------------------------------------------*/
/* Flat panel display wires                                               */
/*------------------------------------------------------------------------*/
	wire hsync_n;
	wire vsync_n;
	wire de;
	wire [7:0] r;
	wire [7:0] g;
	wire [7:0] b;
	
	assign de = hsync_n & vsync_n;
	
/*------------------------------------------------------------------------*/
/* FML to WISHBONE                                                        */
/*------------------------------------------------------------------------*/
	wire [31:0] fml_adr;
	wire [31:0] fml_di;
	wire		fml_stb;
	wire		fml_ack;

	assign fml_di = wb_dat_i;
	assign fml_ack = wb_ack_i;	
	assign wb_adr_o = fml_adr;
	assign wb_stb_o = fml_stb;
	assign wb_cyc_o = fml_stb;
	assign wb_cti_o = 3'b010;
	assign wb_bte_o = 2'b00;
	assign wb_we_o  = 1'b0;
	assign wb_sel_o = 4'hF;
	assign wb_dat_o = 32'h0;
	
/*------------------------------------------------------------------------*/
/* LCD Display Controller & Framebuffer                                   */
/*------------------------------------------------------------------------*/
	vgafb #(
		.csr_addr ( csr_addr	)
	) vgafb (
		.sys_clk		( sys_clk	),
		.sys_rst		( sys_rst	),		
		
		.csr_a			( csr_a		),
		.csr_we			( csr_we	),
		.csr_di			( csr_di	),
		.csr_do			( csr_do	),	
		
		.fml_adr		( fml_adr	),
		.fml_stb		( fml_stb	),
		.fml_ack		( fml_ack	),
		.fml_di			( fml_di	),
		
		.vga_clk		( pixel_clk	),		
		
		.vga_hsync_n	( hsync_n	),
		.vga_vsync_n	( vsync_n	),
		.vga_r			( r			),
		.vga_g			( g			),
		.vga_b			( b			)
	);

/*------------------------------------------------------------------------*/
/* FPD link data serializer                                               */
/*------------------------------------------------------------------------*/	

	video_lvds #(
		.TECHNOLOGY	( TECHNOLOGY )
	) lvds (
		.sys_rst			( sys_rst			),
		.clk_x1				( pixel_clk			),		
		.clk_3x5			( serial_clk		),
							
		.DE					( de				),
		.R					( r					),
		.G					( g					),
		.B					( b					),
							
		.rx0				( rx0				),
		.rx1				( rx1				),
		.rx2				( rx2				),
		.rx3				( rx3				),
		.clk				( clk				)
	);
	
endmodule
