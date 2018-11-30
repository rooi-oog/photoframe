#ifndef __HW_FLASH_H
#define __HW_FLASH_H

#include <hw/common.h>

#define FLASH_CMD_BASE			0x10000000
#define FLASH_CMD				MMPTR (FLASH_CMD_BASE)
#define FLASH_CMD_PRG_BUF		(FLASH_CMD_BASE + 0x100)

/* This should be modified in accordance with user's flash params */
#define FLASH_BLOCK_COUNT		16				// Available blocks free to write
#define FLASH_BLOCK_SIZE		65536
#define FLASH_PAGE_SIZE			256

/* Following values has been slightly increased in comparsion with datasheet */
#define BLOCK_ERASE_TIME		3500			// (tBE) ms
#define PAGE_PROGRAM_TIME		7				// (tPP) ms

#define FLASH_AVAILABLE_SIZE	(FLASH_BLOCK_COUNT * FLASH_BLOCK_SIZE)
#define FLASH_BLOCK_OFFSET		0x10100000

#endif /* __HW_FLASH_H */
