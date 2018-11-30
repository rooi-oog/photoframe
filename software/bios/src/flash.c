#include <stdint.h>
#include <stdio.h>
#include <hw/common.h>
#include <hw/flash.h>
#include "delay.h"

#define SPI_READ			0x03000000
#define SPI_FAST_READ		0x0B000000
#define SPI_PAGE_PGM		0x02000000
#define SPI_CHIP_ERASE		0xC7000000
#define SPI_SECTOR_ERASE	0x20000000
#define SPI_BLOCK_ERASE		0xD8000000
#define SPI_WRITE_ENABLE	0x06000000

void flash_block_erase (uint32_t block_adr)
{
	FLASH_CMD = SPI_WRITE_ENABLE;
	FLASH_CMD = SPI_BLOCK_ERASE | (block_adr & 0x00FFFFFF);
	delay_ms (BLOCK_ERASE_TIME);
}

void flash_page_program (uint32_t offset, uint32_t *ptr)
{
	uint32_t *pgm_mem = (uint32_t *) FLASH_CMD_PRG_BUF;
	
	for (int i = 0; i < FLASH_PAGE_SIZE >> 2; i++)
		*pgm_mem++ = *ptr++;
	
	FLASH_CMD = SPI_WRITE_ENABLE;
	FLASH_CMD = SPI_PAGE_PGM | (offset & 0x00FFFFFF);
	delay_ms (PAGE_PROGRAM_TIME);
}

void flash_write_data (uint32_t *dat, uint32_t size, uint32_t block_address)
{
	uint32_t blocks_to_erase = size / FLASH_BLOCK_SIZE + 1;
	uint32_t flash_offset = block_address;
	
	printf ("Will be erased %d blocks\n", blocks_to_erase);
	
	for (uint32_t i = 0; i < blocks_to_erase; i++) {
		flash_block_erase (flash_offset);		
		printf ("Block %d at: 0x%08X erased\n", i, flash_offset);
		flash_offset += FLASH_BLOCK_SIZE;
	}
	
	flash_offset = block_address;

	for (uint32_t i = 0; i < size / FLASH_PAGE_SIZE + 1; i++) {
		flash_page_program (flash_offset, dat);
		flash_offset += FLASH_PAGE_SIZE;
		dat += FLASH_PAGE_SIZE >> 2;
		printf ("Page %d programmed\n", i);
	}
}
