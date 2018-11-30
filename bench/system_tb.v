`timescale 1ps/1ps

module system_tb;

	reg clk50 = 0; always #5000 clk50 = ~clk50;
	reg reset_n = 0; initial #100000 reset_n = 1;

	wire	[1:0]	sdr_ba;
	wire	[12:0]	sdr_adr;
	wire	[15:0]	sdr_dq;
	wire	[1:0]	sdr_dqm;
	wire			sdr_clk;
	wire			sdr_cke;
	wire			sdr_cs_n;
	wire			sdr_ras_n;
	wire			sdr_cas_n;
	wire			sdr_we_n;
	
	wire			spi_cs;
	wire			spi_clk;
	wire			spi_mosi;
	wire			spi_miso;
	
	wire			uart_rx;
	wire			uart_tx;
	
	wire			mc_clk;
	wire			mc_cmd;
	wire	[3:0]	mc_dat;

pframe pframe (
	.clk50_pad			( clk50		),
	.rst_n_pad			( reset_n	),	
	
	// IS42S16160d SDRAM pins
	.sdram_ba_pad		( sdr_ba	),
	.sdram_adr_pad		( sdr_adr	),
	.sdram_ras_n_pad	( sdr_ras_n	),
	.sdram_cas_n_pad	( sdr_cas_n	),
	.sdram_we_n_pad		( sdr_we_n	),
	.sdram_dq_pad		( sdr_dq	),
	.sdram_dqm_pad		( sdr_dqm	),
	.sdram_clk_pad		( sdr_clk	),
	.sdram_cke_pad		( sdr_cke	),
	.sdram_cs_n_pad		( sdr_cs_n	),
	
	.spi_cs_pad			( spi_cs	),
	.spi_clk_pad		( spi_clk	),
	.spi_mosi_pad		( spi_mosi	),
	.spi_miso_pad		( spi_miso	),
	
	.uart_rx_pad		( uart_rx	),
	.uart_tx_pad		( uart_tx	),
	
	.mc_clk_pad			( mc_clk	),
	.mc_cmd_pad			( mc_cmd	),
	.mc_dat_pad			( mc_dat	)
);   

pullup (uart_rx);
pullup (uart_tx);

mt48lc16m16a2 mem (
//is42s16160d mem (
	.Dq					( sdr_dq 		), 
	.Addr				( sdr_adr		), 
	.Ba					( sdr_ba 		), 
	.Clk				( sdr_clk		), 
	.Cke				( sdr_cke		), 
	.Cs_n				( sdr_cs_n		), 
	.Ras_n				( sdr_ras_n		), 
	.Cas_n				( sdr_cas_n		), 
	.We_n				( sdr_we_n		), 
	.Dqm				( sdr_dqm 		)
);

//m25px16 flash (
//	.C          ( spi_clk	),
//    .SNeg       ( spi_cs	),
//    .DQ0        ( spi_mosi	),
//    .DQ1        ( spi_miso	),
//    .WNeg       ( 1'b0		),
//    .HOLDNeg    ( 1'b1		)
//);

mx25l8006e #(
	.mem_file_name ("none") //("../software/pframe/build/pframe.hex")
) flash (
    .SCLK		( spi_clk	),
    .CSNeg		( spi_cs	),
    .SI			( spi_mosi	),
    .SO			( spi_miso	),
    .WPNeg		( 1'b1		),
    .HOLDNeg	( 1'b1		)
);

sdModel sdmodel (
  .sdClk	( mc_clk	),
  .cmd		( mc_cmd	),
  .dat		( mc_dat	) 
);


initial begin
	$readmemh ("../software/bios/build/pframe_bios.hex", system_tb.pframe.rom.rom);
	//$readmemh ("../software/build/pframe.hex", system_tb.flash.Mem);
	$dumpfile ("system_tb.vcd");
	$dumpvars;
	#20000000000 $finish;
end


endmodule
