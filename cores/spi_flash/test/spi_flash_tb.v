`timescale 1ps/1ps

module spi_flash_tb;

	reg clk = 0; always #5000 clk = ~clk;
	reg rst = 1; initial #20000 rst = 0;

	reg	 [31:0]	adr;
	reg	 [31:0]	dat_w;
	wire [31:0]	dat_r;
	reg			stb;
	reg			cyc;
	reg			we;
	wire		ack;
	
	wire		spi_cs;
	wire		spi_clk;
	wire		spi_miso;
	wire		spi_mosi;

`include "spi_flash_params.vh"
	
spi_flash #(
	.CLOCK_SEL (1)
) spi_flash (
	.sys_clk	( clk		),
	.sys_rst	( rst		),
	
	.adr_i		( adr		),
	.dat_i		( dat_w		),
	.dat_o		( dat_r		),
	.sel_i		( 			),
	.stb_i		( stb		),
	.cyc_i		( cyc		),
	.we_i		( we		),
	.ack_o		( ack		),
	
	.spi_cs_n	( spi_cs	),
	.spi_clk	( spi_clk	),
	.spi_mosi	( spi_mosi	),
	.spi_miso	( spi_miso	)
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

task waitclock;
begin
	@(posedge clk);
	#1;
end
endtask

task waitnclock;
input [15:0] n;
integer i;
begin
	for(i=0;i<n;i=i+1)
		waitclock;
end
endtask

task spi_read;
input [31:0] addr;
begin
	stb <= 1'b1;
	cyc <= 1'b1;
	adr <= addr;
	we <= 1'b0;
	while (~ack) begin
		waitclock;
	end
	waitclock;
	stb <= 1'b0;
	cyc <= 1'b0;
	
	$display ("read data: %08x:%0d\n", addr [23:2], dat_r);
end	
endtask

task spi_write;
input [31:0] addr;
input [31:0] dat;
input [7:0] cmd;
begin
	stb <= 1'b1;
	cyc <= 1'b1;
	dat_w <= {cmd, dat [23:0]};
	adr <= addr;
	we <= 1'b1;
	while (~ack) begin
		waitclock;
	end
	waitclock;
	stb <= 1'b0;
	cyc <= 1'b0;
end	
endtask

integer n;
initial begin
	stb <= 1'b0;
	cyc <= 1'b0;
	adr <= 'd0;
	dat_w <= 'd0;
	we <= 1'b0;
	
	#200010000
	
	waitclock;
	for (n = 0; n < 256; n = n + 4) begin
		spi_write (32'h100 + n, n / 4 + 1, 0);
	end
	
	waitnclock (4);
	spi_write (32'h08, 32'h0, SPI_WRITE_ENABLE);
	
	waitnclock (4);
	spi_write (32'h0C, 32'h0, SPI_PAGE_PGM);
	
	waitnclock (50);
	spi_read (32'h04);
	
	waitnclock (100);	
	$finish;

end

initial begin
	$dumpfile ("spi_flash_tb.vcd");
	#200000000 $dumpvars;
//	#20000000 $finish;
end


endmodule
