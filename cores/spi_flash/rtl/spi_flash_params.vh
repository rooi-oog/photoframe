localparam FSM_IDLE			= 2'b00;
localparam FSM_ACT			= 2'b01;
localparam FSM_PGM			= 2'b10;
localparam FSM_WAIT			= 2'b11;

localparam SPI_READ			= 8'h03;
localparam SPI_FAST_READ	= 8'h0B;
localparam SPI_PAGE_PGM		= 8'h02;
localparam SPI_CHIP_ERASE	= 8'hC7;
localparam SPI_SECTOR_ERASE	= 8'h20;
localparam SPI_BLOCK_ERASE	= 8'hD8; 
localparam SPI_WRITE_ENABLE	= 8'h06;
