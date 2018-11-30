module spi_flash #(
	parameter SECTOR_SIZE	= 4096,
	parameter PAGE_SIZE		= 256,
	parameter CLOCK_SEL		= 0	
)(
	input				sys_clk,
	input				sys_rst,
	
	input		[31:0]	adr_i,
	input		[31:0]	dat_i,
	output reg	[31:0]	dat_o,
	input		[ 3:0]	sel_i,
	input				stb_i,
	input				cyc_i,
	input				we_i,
	output reg			ack_o,
	
	output 				spi_cs_n,
	output				spi_clk,
	output				spi_mosi,
	input				spi_miso
);
	`include "spi_flash_params.vh"
	
	reg			pgm_mem_we;
	wire		pgm_mem_rd_clk;
	wire [5:0]	pgm_mem_rd_adr;
	wire [31:0]	pgm_mem_rd_dat;
	
	reg  [7:0]	spi_cmd;
	reg  [23:0] spi_adr;
	wire [31:0]	spi_rd_dat;
	reg			spi_op_done;

	reg [1:0] 	state;
	
	always @(posedge sys_clk)
		dat_o <= spi_rd_dat;
		
	always	@(posedge sys_clk)
		spi_op_done <= spi_cs_n;
		
	always	@(posedge sys_clk or posedge sys_rst) begin
		if (sys_rst) begin					
			ack_o <= 1'b0;
			pgm_mem_we <= 1'b0;
			state <= FSM_IDLE;
		end else begin
			ack_o <= 1'b0;
			pgm_mem_we <= 1'b0;						
			
			case (state)
				FSM_IDLE: if (stb_i & cyc_i & ~ack_o) begin
					spi_cmd <= dat_i [31:24];
					if (~we_i) begin
						spi_cmd <= SPI_FAST_READ;
						spi_adr <= {adr_i [23:2], 2'b00};
						state <= FSM_ACT;
					end else begin
						spi_cmd <= dat_i [31:24];
						spi_adr <= dat_i [23:0];
						state <= adr_i [8] ? FSM_IDLE : FSM_ACT;
						pgm_mem_we <= adr_i [8];
						ack_o <= adr_i [8];
					end

//					if (~we_i) begin
//						spi_cmd <= SPI_FAST_READ;
//						spi_adr <= {adr_i [23:2], 2'b00};
//						state <= FSM_ACT;
//					end else begin
//						spi_adr <= dat_i [23:0];
//						state <= FSM_ACT;
//						casex (adr_i [8:2])
//							7'b0xxxx00: spi_cmd <= SPI_BLOCK_ERASE;
//							7'b0xxxx01: spi_cmd <= SPI_SECTOR_ERASE;
//							7'b0xxxx10: spi_cmd <= SPI_WRITE_ENABLE;
//							7'b0xxxx11: spi_cmd <= SPI_PAGE_PGM;
//							7'b1xxxxxx:	begin
//								pgm_mem_we <= 1'b1;
//								ack_o <= 1'b1;
//								state <= FSM_IDLE;
//							end
//						endcase
//					end
				end
					
				FSM_ACT: if (~spi_op_done)
					state <= FSM_WAIT;
					
				FSM_WAIT: if (spi_op_done) begin
					ack_o <= 1'b1;
					state <= FSM_IDLE;
				end
					
			endcase			
		end         
	end
	
	flash_ctrl #(
		.CLOCK_SEL		( CLOCK_SEL			)
	) 
	flash_ctrl (
		.sys_clk		( sys_clk			),
		.sys_rst		( sys_rst			),

		.fsm_cmd		( state				),
		.spi_cmd		( spi_cmd			),
		.spi_adr		( spi_adr			),
		.spi_dat		( spi_rd_dat		),
		
		.pgm_mem_rd_clk	( pgm_mem_rd_clk	),
		.pgm_mem_rd_adr	( pgm_mem_rd_adr	),
		.pgm_mem_rd_dat	( pgm_mem_rd_dat	),

		.spi_clk		( spi_clk			),
		.spi_cs_n		( spi_cs_n			),
		.spi_mosi		( spi_mosi			),
		.spi_miso		( spi_miso			)	
	);

	simple_dual_ram #(
		.DATA_WIDTH (32), 
		.ADDR_WIDTH (6)	// TODO: to fit to page size
	) page_pgm_mem (
		.write_clock	( sys_clk			),
		.write_addr		( adr_i [7:2]		),
		.data			( dat_i 			),
		.we				( pgm_mem_we		), 		
		.read_clock		( pgm_mem_rd_clk	),		
		.read_addr		( pgm_mem_rd_adr	),				
		.q				( pgm_mem_rd_dat	)		
	);
	
	

endmodule
