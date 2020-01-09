`include "config.v"
`include "lm32_config.v"

module pframe (
	// Global clock && reset
	input			clk50_pad,
	input			rst_n_pad,	
	
	// HannStar HDS101PWW2 LVDS pins
	output			rx0_pad, 	
	output			rx1_pad,
	output			rx2_pad,
	output			rx3_pad,
	output			clk_pad,	
	output			lcd_pwm,
	
	// IS42S16160d SDRAM pins
	output	[1:0]	sdram_ba_pad,		
	output	[12:0]	sdram_adr_pad,		
	output			sdram_ras_n_pad,	
	output			sdram_cas_n_pad,	
	output			sdram_we_n_pad,
	inout	[15:0]	sdram_dq_pad,
	output	[ 1:0]	sdram_dqm_pad,
	output			sdram_clk_pad,
	output			sdram_cke_pad,
	output			sdram_cs_n_pad,
	
	// SPI FLASH pins
	output			spi_mosi_pad,
    input			spi_miso_pad,
    output			spi_cs_pad,
    output			spi_clk_pad,
    
    // UART pins
    input			uart_rx_pad,
    output			uart_tx_pad,
    
    // SD card pins
    inout	[3:0]	mc_dat_pad,
    inout			mc_cmd_pad,
    output			mc_clk_pad,
    
    // LEDs pin
    output	[3:0]	leds_pad
);

/*------------------------------------------------------------------------*/
/* Wishbone master wires (direct memory bus)                              */
/*------------------------------------------------------------------------*/
	wire [31:0]	wb_vga_adr;
	wire [0:0]	wb_vga_stb;
	wire [0:0]	wb_vga_cyc;
	wire [2:0]	wb_vga_cti;
	wire [1:0]	wb_vga_bte;
	wire [0:0]	wb_vga_we;
	wire [3:0]	wb_vga_sel;
	wire [31:0]	wb_vga_dat;
	wire [31:0]	wb_vga_rdt;
	wire [0:0]	wb_vga_ack;

	wire [31:0]	wb_cpu_adr;
	wire [0:0]	wb_cpu_stb;
	wire [0:0]	wb_cpu_cyc;
	wire [2:0]	wb_cpu_cti;
	wire [1:0]	wb_cpu_bte;
	wire [0:0]	wb_cpu_we;
	wire [3:0]	wb_cpu_sel;
	wire [31:0]	wb_cpu_dat;
	wire [31:0]	wb_cpu_rdt;
	wire [0:0]	wb_cpu_ack;
	
/*------------------------------------------------------------------------*/
/* Wishbone master wires                                                  */
/*------------------------------------------------------------------------*/

	wire [31:0]	cpubus_adr;
	wire [2:0]	cpubus_cti	= 3'b000;
	wire [31:0]	cpubus_dat_r;
	wire [31:0]	cpubus_dat_w;
	wire [3:0]	cpubus_sel;
	wire		cpubus_we;
	wire		cpubus_cyc;
	wire		cpubus_stb;
	wire		cpubus_ack;

/*------------------------------------------------------------------------*/
/* Wishbone slave wires                                                   */
/*------------------------------------------------------------------------*/
	wire [31:0]	wb_rom_adr;
	wire 		wb_rom_stb;
	wire 		wb_rom_cyc;
	wire [2:0]	wb_rom_cti;
	wire [1:0]	wb_rom_bte;
	wire 		wb_rom_we;
	wire [3:0]	wb_rom_sel;
	wire [31:0]	wb_rom_dat;
	wire [31:0]	wb_rom_rdt;
	wire 		wb_rom_ack;
	
	wire [31:0]	wb_flash_adr;
	wire 		wb_flash_stb;
	wire 		wb_flash_cyc;
	wire [2:0]	wb_flash_cti;
	wire [1:0]	wb_flash_bte;
	wire 		wb_flash_we;
	wire [3:0]	wb_flash_sel;
	wire [31:0]	wb_flash_dat;
	wire [31:0]	wb_flash_rdt;
	wire 		wb_flash_ack;
	
	wire [31:0]	wb_csr_adr;
	wire 		wb_csr_stb;
	wire 		wb_csr_cyc;
	wire [2:0]	wb_csr_cti;
	wire [1:0]	wb_csr_bte;
	wire 		wb_csr_we;
	wire [3:0]	wb_csr_sel;
	wire [31:0]	wb_csr_dat;
	wire [31:0]	wb_csr_rdt;
	wire 		wb_csr_ack;
	
/*------------------------------------------------------------------------*/
/* CSR bus                                                                */
/*------------------------------------------------------------------------*/
	wire [13:0]	csr_a;
	wire		csr_we;
	wire [31:0]	csr_dw;
	wire [31:0]	csr_dr_uart,
				csr_dr_sysctl,
				csr_dr_vga,
				csr_dr_memcard;
				
		
/*------------------------------------------------------------------------*/
/* Clock & reset                                                          */
/*------------------------------------------------------------------------*/	
	wire		sys_clk;								// 100MHz
	wire		sdram_clk;								// 100MHz
	wire		pixel_clk;								// 50MHz should be as low as possible 'cause we display a static image
	wire		serial_clk;								// 175MHz
									
	wire [1:0]	clk_locked;
	wire		sys_rst;
			
	wire		hard_reset;
	wire		sysctl_reset;
	reg	 [19:0]	reset;
	
	/*
	 * We must release the Flash reset before the system reset
	 * because the Flash needs some time to come out of reset
	 * and the CPU begins fetching instructions from it
	 * as soon as the system reset is released.
	 * From datasheet, minimum reset pulse width is 100ns
	 * and reset-to-read time is 150ns.
	 */
	always	@(posedge sys_clk or posedge hard_reset) begin
		if (hard_reset)
			reset <= 20'h04FFF;
		else if (reset != 20'h00000)
			reset <= reset - 20'h00001;
	end
	
	assign hard_reset	= ~rst_n_pad | ~clk_locked [1] | ~clk_locked [0] | sysctl_reset;
	assign sys_rst		= reset != 20'h00000;	

/*------------------------------------------------------------------------*/
/* PLLs                                                                   */
/*------------------------------------------------------------------------*/
	pll_x1 pll_x1 (
		.inclk0			( clk50_pad			),
		.c0				( sys_clk			),
		.c1				( sdram_clk			),
		.locked			( clk_locked [0]	)
	);
	
		
	pll_3x5 pll_3x5 (
		.inclk0			( clk50_pad			),
		.c0				( pixel_clk			),
		.c1				( serial_clk		),
		.locked			( clk_locked [1]	)	
	);


/*------------------------------------------------------------------------*/
/* Wishbone switch                                                        */
/*------------------------------------------------------------------------*/
// boot rom     0x00000000 (shadow @0x80000000)
// flash        0x10000000 (shadow @0x90000000)
// sdram        0x20000000 (shadow @0xa0000000)
// csr bridge   0x30000000 (shadow @0xb0000000)

	// MSB (Bit 31) is ignored for slave address decoding (that isn't fucking true!)
	conbus5x6 #(
		.s0_addr(3'b000),	// rom
		.s1_addr(3'b001),	// flash
		.s2_addr(3'b010),	// sdram
		.s3_addr(3'b011)	// csr bridge
	) wbswitch (
		.sys_clk(sys_clk),
		.sys_rst(sys_rst),

		// Master 0
		.m0_dat_o	(	),
		.m0_adr_i	( 32'hx	),
		.m0_cti_i	( 3'hx	),
		.m0_we_i	( 1'bx	),
		.m0_dat_i	( 32'hx	),
		.m0_sel_i	( 4'hf	),		
		.m0_cyc_i	( 1'b0	),
		.m0_stb_i	( 1'b0	),
		.m0_ack_o	(	),
		
		// Master 1
		.m1_dat_i	(cpubus_dat_w),
		.m1_dat_o	(cpubus_dat_r),
		.m1_adr_i	(cpubus_adr),
		.m1_cti_i	(cpubus_cti),
		.m1_we_i	(cpubus_we),
		.m1_sel_i	(cpubus_sel),
		.m1_cyc_i	(cpubus_cyc),
		.m1_stb_i	(cpubus_stb),
		.m1_ack_o	(cpubus_ack),

		// Slave 0
		.s0_dat_i(wb_rom_rdt),
		.s0_dat_o(wb_rom_dat),
		.s0_adr_o(wb_rom_adr),
		.s0_cti_o(wb_rom_cti),
		.s0_sel_o(wb_rom_sel),
		.s0_we_o (wb_rom_we),
		.s0_cyc_o(wb_rom_cyc),
		.s0_stb_o(wb_rom_stb),
		.s0_ack_i(wb_rom_ack),
		
		// Slave 1
		.s1_dat_i(wb_flash_rdt),
		.s1_dat_o(wb_flash_dat),
		.s1_adr_o(wb_flash_adr),
		.s1_cti_o(wb_flash_cti),
		.s1_sel_o(wb_flash_sel),
		.s1_we_o (wb_flash_we),
		.s1_cyc_o(wb_flash_cyc),
		.s1_stb_o(wb_flash_stb),
		.s1_ack_i(wb_flash_ack),
		
		// Slave 2
		.s2_dat_i(wb_cpu_rdt),
		.s2_dat_o(wb_cpu_dat),
		.s2_adr_o(wb_cpu_adr),
		.s2_cti_o(wb_cpu_cti),
		.s2_sel_o(wb_cpu_sel),
		.s2_we_o (wb_cpu_we),
		.s2_cyc_o(wb_cpu_cyc),
		.s2_stb_o(wb_cpu_stb),
		.s2_ack_i(wb_cpu_ack),
		
		// Slave 3
		.s3_dat_i(wb_csr_rdt),
		.s3_dat_o(wb_csr_dat),
		.s3_adr_o(wb_csr_adr),
		.s3_cti_o(wb_csr_cti),
		.s3_sel_o(wb_csr_sel),
		.s3_we_o (wb_csr_we),
		.s3_cyc_o(wb_csr_cyc),
		.s3_stb_o(wb_csr_stb),
		.s3_ack_i(wb_csr_ack)
	);

/*------------------------------------------------------------------------*/
/* WISHBONE to CSR bridge                                                 */
/*------------------------------------------------------------------------*/
	csrbrg csrbrg (
		.sys_clk		( sys_clk		),
		.sys_rst		( sys_rst		),		

		.wb_adr_i		( wb_csr_adr	),
		.wb_dat_i		( wb_csr_dat	),
		.wb_dat_o		( wb_csr_rdt	),
		.wb_cyc_i		( wb_csr_cyc	),
		.wb_stb_i		( wb_csr_stb	),
		.wb_we_i		( wb_csr_we		),
		.wb_ack_o		( wb_csr_ack	),		

		.csr_a			( csr_a			),
		.csr_we			( csr_we		),
		.csr_do			( csr_dw		),
		.csr_di			( csr_dr_uart
						 |csr_dr_sysctl
						 |csr_dr_vga
						 |csr_dr_memcard	)
	);

/*------------------------------------------------------------------------*/
/* Flat panel control module                                              */
/*------------------------------------------------------------------------*/
	fpd_link #(
		.csr_addr 		( 4'h2 ),
`ifndef SIMULATION
		.TECHNOLOGY		(`ALTERA_LVDS)
`else
		.TECHNOLOGY		(`GENERIC_LVDS)
`endif
	) FPD_Link (
		.sys_clk			( sys_clk			),
		.sys_rst			( sys_rst			),
		.pixel_clk			( pixel_clk			),
		.serial_clk			( serial_clk		),		

		.csr_a				( csr_a				),
		.csr_di				( csr_dw			),
		.csr_do				( csr_dr_vga		),
		.csr_we				( csr_we			),

		.clk				( clk_pad			),
		.rx0				( rx0_pad			),
		.rx1				( rx1_pad			),
		.rx2				( rx2_pad			),
		.rx3				( rx3_pad			),

		.wb_adr_o			( wb_vga_adr		),
		.wb_dat_i			( wb_vga_rdt		),
		.wb_dat_o			( wb_vga_dat		),
		.wb_sel_o			( wb_vga_sel		),
		.wb_cti_o			( wb_vga_cti		),
		.wb_bte_o			( wb_vga_bte		),
		.wb_cyc_o			( wb_vga_cyc		),
		.wb_stb_o			( wb_vga_stb		),
		.wb_we_o			( wb_vga_we			),
		.wb_ack_i			( wb_vga_ack		)		
	);	
	
/*------------------------------------------------------------------------*/
/* Lattice Mico32 CPU Interrupt lines                                     */
/*------------------------------------------------------------------------*/
wire uart_irq;
wire gpio_irq;
wire timer0_irq;
wire timer1_irq;

wire [31:0] cpu_interrupt;
assign cpu_interrupt = {16'd0,
	timer1_irq,
	timer0_irq,
	gpio_irq,
	uart_irq
};

/*------------------------------------------------------------------------*/
/* PicoRV32 CPU                                                           */
/*------------------------------------------------------------------------*/

wire [31:0]	cpu_mem_adr;
wire		cpu_mem_instr;
assign		cpubus_adr = cpu_mem_adr; //{cpu_mem_instr, cpu_mem_adr [30:0]};

picorv32_wb #(
	.ENABLE_COUNTERS 		( 0	),
	.ENABLE_COUNTERS64		( 0	),
	.ENABLE_REGS_16_31		( 1	),
	.ENABLE_REGS_DUALPORT	( 1	),
	.TWO_STAGE_SHIFT		( 1	),
	.BARREL_SHIFTER			( 0	),
	.TWO_CYCLE_COMPARE		( 0	),
	.TWO_CYCLE_ALU			( 0	),
	.COMPRESSED_ISA			( 0	),
	.CATCH_MISALIGN			( 1	),
	.CATCH_ILLINSN			( 1	),
	.ENABLE_PCPI			( 0	),
	.ENABLE_MUL				( 0	),
	.ENABLE_FAST_MUL		( 0	),
	.ENABLE_DIV				( 0	),
	.ENABLE_IRQ				( 0	),
	.ENABLE_IRQ_QREGS		( 1	),
	.ENABLE_IRQ_TIMER		( 1	),
	.ENABLE_TRACE			( 0	),
	.REGS_INIT_ZERO			( 0	),
	.MASKED_IRQ				( 32'h0000_0000	),
	.LATCHED_IRQ			( 32'hffff_ffff	),
	.PROGADDR_RESET			( 32'h0000_0000	),
	.PROGADDR_IRQ			( 32'h0000_0010	),
	.STACKADDR				( 32'hffff_ffff	)
) picorv32 (
	.trap					( ),

	// Wishbone interfaces
	.wb_rst_i				( sys_rst		),
	.wb_clk_i				( sys_clk		),

	.wbm_adr_o				( cpu_mem_adr	),
	.wbm_dat_o				( cpubus_dat_w	),
	.wbm_dat_i				( cpubus_dat_r	),
	.wbm_we_o				( cpubus_we		),
	.wbm_sel_o				( cpubus_sel	),
	.wbm_stb_o				( cpubus_stb	),
	.wbm_ack_i				( cpubus_ack	),
	.wbm_cyc_o				( cpubus_cyc	),

	// Pico Co-Processor Interface (PCPI)
	.pcpi_valid				(	),
	.pcpi_insn				(	),
	.pcpi_rs1				(	),
	.pcpi_rs2				(	),
	.pcpi_wr				(	),
	.pcpi_rd				(	),
	.pcpi_wait				(	),
	.pcpi_ready				(	),

	// IRQ interface
	.irq					(	),
	.eoi					(	),

	// Trace Interface
	.trace_valid			(	),
	.trace_data				(	),

	.mem_instr				( cpu_mem_instr	)
);

/*------------------------------------------------------------------------*/
/* Boot read only memory                                                  */
/*------------------------------------------------------------------------*/    
	wb_rom rom (
		.wb_clk_i	( sys_clk		),
		.wb_rst_i	( sys_rst		),
		.wb_adr_i	( wb_rom_adr	),
		.wb_dat_i	( wb_rom_dat	),
		.wb_dat_o	( wb_rom_rdt	),
		.wb_sel_i	( wb_rom_sel	),
		.wb_cti_i	( wb_rom_cti	),
		.wb_bte_i	( wb_rom_bte	),
		.wb_cyc_i	( wb_rom_cyc	),
		.wb_stb_i	( wb_rom_stb	),
		.wb_we_i	( wb_rom_we		),
		.wb_ack_o	( wb_rom_ack	)
	);

/*------------------------------------------------------------------------*/
/* Flash memory                                                           */
/*------------------------------------------------------------------------*/
	spi_flash #(
		.CLOCK_SEL 	( 2	)
	) spi_flash (
		.sys_clk	( sys_clk		),
		.sys_rst	( sys_rst		),
		
		.adr_i		( wb_flash_adr	),
		.dat_i		( wb_flash_dat	),
		.dat_o		( wb_flash_rdt	),
		.sel_i		( wb_flash_sel	),
		.stb_i		( wb_flash_stb	),
		.cyc_i		( wb_flash_cyc	),
		.we_i		( wb_flash_we	),
		.ack_o		( wb_flash_ack	),
		
		.spi_cs_n	( spi_cs_pad	),
		.spi_clk	( spi_clk_pad	),
		.spi_mosi	( spi_mosi_pad	),
		.spi_miso	( spi_miso_pad	)
	);

/*------------------------------------------------------------------------*/
/* UART                                                                   */
/*------------------------------------------------------------------------*/
	uart #(
		.csr_addr	( 4'h0				),
		.clk_freq	( `CLOCK_FREQUENCY	),
		.baud		( `BAUD_RATE		),
		.break_en_default	( 1'b1		)
	) uart (
		.sys_clk	( sys_clk			),
		.sys_rst	( sys_rst			),

		.csr_a		( csr_a				),
		.csr_we		( csr_we			),
		.csr_di		( csr_dw			),
		.csr_do		( csr_dr_uart		),

		.irq		( uart_irq			),

		.uart_rx	( uart_rx_pad		),
		.uart_tx	( uart_tx_pad		),

	`ifdef CFG_EXTERNAL_BREAK_ENABLED
		.break		( ext_break			)
	`else
		.break		( )
	`endif
	);

/*------------------------------------------------------------------------*/
/* SD card controller                                                     */
/*------------------------------------------------------------------------*/
	memcard #(
		.csr_addr	( 4'h3 )
	) memcard (
		.sys_clk	( sys_clk			),
		.sys_rst	( sys_rst			),

		.csr_a		( csr_a				),
		.csr_we		( csr_we			),
		.csr_di		( csr_dw			),
		.csr_do		( csr_dr_memcard	),

		.mc_d		( mc_dat_pad		),
		.mc_cmd		( mc_cmd_pad		),
		.mc_clk		( mc_clk_pad		)
	);
	
/*------------------------------------------------------------------------*/
/* SDRAM controller unit                                                  */
/*------------------------------------------------------------------------*/
	wire 	[15:0]  sdram_dq_o;
	wire			sdram_dq_oe;
   
	assign sdram_dq_pad	 = sdram_dq_oe ? sdram_dq_o : 16'bz;
	assign sdram_clk_pad = sdram_clk;
	
	wb_sdram_ctrl #(
	`ifdef SIMULATION
		.TECHNOLOGY		("GENERIC"),       
		.POWERUP_DELAY	(10),	
	`else		
		.TECHNOLOGY		("ALTERA"),
		.POWERUP_DELAY	(200),		// power up delay in us
	`endif
		.CLK_FREQ_MHZ	(100),		// sdram_clk freq in MHZ
		.BURST_LENGTH	(8),		// 0), 1), 2), 4 or 8 (0 = full page)
		.WB_PORTS		(2),		// Number of wishbone ports
		.BUF_WIDTH		(3),		// Buffer size = 2^BUF_WIDTH
		.ROW_WIDTH		(13),		// Row width
		.COL_WIDTH		(9),		// Column width
		.BA_WIDTH		(2),		// Ba width
		.tCAC			(2),		// CAS Latency
		.tRAC			(5),		// RAS Latency
		.tRP			(3),		// Command Period (PRE to ACT) //// 2
		.tRC			(9),		// Command Period (REF to REF / ACT to ACT)  //// 7
		.tMRD			(3)			// Mode Register Set To Command Delay time
	) wb_sdram_ctrl (
		// SDRAM interface
		.sdram_clk		( sdram_clk_pad		),
		.sdram_rst		( sys_rst			),
		
		.ba_pad_o		( sdram_ba_pad		),
		.a_pad_o		( sdram_adr_pad		),
		.cs_n_pad_o		( sdram_cs_n_pad	),
		.ras_pad_o		( sdram_ras_n_pad	),
		.cas_pad_o		( sdram_cas_n_pad	),
		.we_pad_o		( sdram_we_n_pad	),
		.dq_i			( sdram_dq_pad		),
		.dq_o			( sdram_dq_o		),
		.dqm_pad_o		( sdram_dqm_pad		),
		.dq_oe			( sdram_dq_oe		),
		.cke_pad_o		( sdram_cke_pad		),		

		// Wishbone interface
		.wb_clk   		( sys_clk	),
		.wb_rst   		( sys_rst	),
		.wb_adr_i 		( {wb_cpu_adr, wb_vga_adr} ),
		.wb_stb_i 		( {wb_cpu_stb, wb_vga_stb} ),
		.wb_cyc_i 		( {wb_cpu_cyc, wb_vga_cyc} ),
		.wb_cti_i 		( {wb_cpu_cti, wb_vga_cti} ),
		.wb_bte_i 		( {wb_cpu_bte, wb_vga_bte} ),
		.wb_we_i  		( {wb_cpu_we,  wb_vga_we}  ) ,
		.wb_sel_i 		( {wb_cpu_sel, wb_vga_sel} ),
		.wb_dat_i 		( {wb_cpu_dat, wb_vga_dat} ),
		.wb_dat_o 		( {wb_cpu_rdt, wb_vga_rdt} ),
		.wb_ack_o 		( {wb_cpu_ack, wb_vga_ack} )
	);
		
endmodule
