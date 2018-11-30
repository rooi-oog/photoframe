module flash_ctrl #(
	parameter CLOCK_SEL	= 0		
)(
	input				sys_clk,
	input				sys_rst,
	
	input		[1:0]	fsm_cmd,
	input		[7:0]	spi_cmd,
	input		[23:0]	spi_adr,
	output reg	[31:0]	spi_dat,
	
	output				pgm_mem_rd_clk,
	output		[5:0]	pgm_mem_rd_adr,
	input		[31:0]	pgm_mem_rd_dat,	
	
	output				spi_clk,
	output				spi_cs_n,
	output reg			spi_mosi,
	input				spi_miso	
);
	`include "spi_flash_params.vh"

	reg			spi_cs;
	reg  [11:0]	spi_op_cnt;
	
	reg			clk_div;        // clock divided by CLOCK_SEL	
	reg [3:0]	clk_cnt;        // clock number counte
	
	wire [7:0]	short_cmd = spi_cmd;
	wire [31:0] long_cmd = {spi_cmd, spi_adr};
	wire [71:0]	read_cmd = {spi_cmd, spi_adr, 8'bx, 32'bx};
	wire		spi_op_while;
	
	assign spi_cs_n = ~spi_cs;
	assign spi_clk = CLOCK_SEL > 0 ? clk_cnt [CLOCK_SEL] : sys_clk;
//	assign spi_clk = CLOCK_SEL > 0 ? clk_div : sys_clk;
	
	assign pgm_mem_rd_clk =  spi_op_cnt [4];
	assign pgm_mem_rd_adr = ~spi_op_cnt [10:5]; //6'd63 - spi_op_cnt [10:5];

	assign spi_op_while = spi_op_cnt != 0;

	always @(posedge sys_clk or posedge sys_rst) begin
		if (sys_rst) begin
			clk_cnt <= 4'h0;
		end else
			clk_cnt <= clk_cnt + 1;
	end
	
//	always @(posedge sys_clk or posedge sys_rst) begin
//		if (sys_rst) begin
//			clk_cnt <= 4'h0;
//			clk_div <= 0;
//		end else if (clk_cnt == CLOCK_SEL - 1) begin
//			clk_div <= ~clk_div;
//			clk_cnt <= 4'h0;
//		end else
//			clk_cnt <= clk_cnt + 1;
//	end
	
	always @* begin
		case (spi_cmd)
			SPI_FAST_READ: spi_mosi <= read_cmd [spi_op_cnt];
			SPI_WRITE_ENABLE: spi_mosi <= short_cmd [spi_op_cnt [3:0]];
			SPI_BLOCK_ERASE: spi_mosi <= long_cmd [spi_op_cnt [4:0]];
			SPI_SECTOR_ERASE: spi_mosi <= long_cmd [spi_op_cnt [4:0]];
			SPI_PAGE_PGM: spi_mosi <= ~spi_op_cnt [11] ? pgm_mem_rd_dat [spi_op_cnt [4:0]] : long_cmd [spi_op_cnt [4:0]];
			default: spi_mosi <= 1'bx;
		endcase			
	end

	always	@(negedge spi_clk or posedge sys_rst) begin
		if (sys_rst) begin
			spi_cs <= 1'b0;
		end else if (fsm_cmd == FSM_ACT)
			spi_cs <= 1'b1;
		else
			spi_cs <= spi_op_while;
	end
	
	always @(posedge spi_clk) begin		
		if (spi_cs)
			spi_dat <= {spi_dat [30:0], spi_miso};
	end	
	
	always	@(negedge spi_clk or posedge sys_rst) begin
		if (sys_rst) begin
			spi_op_cnt <= 'd0;
		end else begin
			if (fsm_cmd == FSM_ACT & ~spi_cs) begin
				case (spi_cmd)
					SPI_FAST_READ:
						spi_op_cnt <= 12'd71;
					SPI_WRITE_ENABLE:
						spi_op_cnt <= 12'd7;
					SPI_BLOCK_ERASE:
						spi_op_cnt <= 12'd31;
					SPI_SECTOR_ERASE:
						spi_op_cnt <= 12'd31;
					SPI_PAGE_PGM:
						spi_op_cnt <= 12'd2079;
					default: spi_op_cnt <= 12'bx;
				endcase
			end else if (spi_op_while)
				spi_op_cnt <= spi_op_cnt - 1'b1;
		end
	end
	
endmodule
