#ifndef __FLASH_H
#define __FLASH_H

void flash_block_erase (uint32_t);
void flash_sector_erase (uint32_t);
void flash_page_program (uint32_t, uint32_t *);
void flash_write_data (uint32_t *, uint32_t, uint32_t);

#endif /* __FLASH_H */

