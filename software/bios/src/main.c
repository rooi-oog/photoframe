#include <stdio.h>
#include <stdint.h>
#include <stdlib.h>
#include <string.h>

#include "hw/common.h"
#include "hw/flash.h"
#include "hw/sysctl.h"
#include "hw/gpio.h"
#include "irq.h"
#include "uart.h"
#include "flash.h"

#define FLASH_BOOT		0x00
#define SERIAL_BOOT		0x11
#define SDRAM_BOOT		0x22

#define BOOT_DELAY 		5 * 1000000
#define SDRAM_OFFSET	0x20000000		// TODO: depends of pframe's linker.ld

struct fws {
	uint32_t length;
	uint16_t crc;
	uint32_t payload [FLASH_AVAILABLE_SIZE / 4];
};


static int boot_select (void)
{
	uint32_t time_offset;
	int32_t boot_delay = BOOT_DELAY;
	uint8_t result = FLASH_BOOT;	
	
	for (;;) {
		time_offset = SIMPLE_COUNTER;			
		
		if (uart_read_nonblock ()) {
			result = uart_read ();
			break;
		}		
		
		if ((boot_delay -= (SIMPLE_COUNTER - time_offset)) < 0)
			break;
	}

	return result;
}

static void serial_load_firmware (struct fws *fw)
{
	/* TODO:
	 *	CRC checking
	 */	 
	for (uint8_t i = 0; i < 4; i++)
		((uint8_t *) &(fw->length)) [i] = uart_read ();
	
	/* Check if we have enough space */
	if (FLASH_AVAILABLE_SIZE < fw->length) {
		printf ("Available flash size is %d bytes, but requested size is %d\n", 
					FLASH_AVAILABLE_SIZE, fw->length);	
		uart_force_sync (1);
		irq_enable (0);
		/* Doesn't know what to do. Halt. */
		for (;;);
	}

	/* Receive firmware code by uart */
	for (uint32_t i = 0; i < fw->length >> 2; i++)
		for (uint8_t j = 0; j < 4; j++)
			((uint8_t *) fw->payload) [i * 4 + j] = uart_read ();

	
	printf ("Loaded successfully\n");
}

static void store_firmware (struct fws *fw, uint32_t block_address)
{
	printf ("Starting flashing flash...\n");
	
	/* Write payload to spi flash */
	flash_write_data (fw->payload, fw->length, block_address);	
		
	uint32_t *spi_flash = (uint32_t *) block_address;
	
	/* Check if written successfully */	
	for (uint32_t i = 0; i < fw->length >> 2; i++) {
		if (*spi_flash != fw->payload [i]) {
			printf ("Read\\Write fail:\t"
				"addr: 0x%08X, payload = 0x%08X, spi = 0x%08X\n", spi_flash, fw->payload [i], *spi_flash);
			/* Something bad happened. No further move */
			for (;;);
		}
		spi_flash++;
	}

	printf ("Written successfully\n"); // no way it'll be unsuccessful :)))
}

static void load_firmware (uint32_t *dest, uint32_t *src, uint32_t dwords)
{
	while (dwords-- > 0)
		*dest++ = *src++;
}
	
int main (void)
{	
	struct fws fw;
	uint32_t *firmware_source = (uint32_t *) FLASH_BLOCK_OFFSET;
	uint32_t firmware_length = FLASH_AVAILABLE_SIZE;
	
	/* Nothing useful, just for calmness */
	CSR_GPIO_OUT = LED0;
	
	/* Mask all interrupts */
	irq_setmask (0);
	/* Global interrupt enable */
	irq_enable (1);	
	/* UART initialization */
	uart_init ();
	
	printf (
		"----------------------------------------------------------\n"
		"Digital photoframe bootloader\n"
		"----------------------------------------------------------\n");
	
	printf ("Waiting for new firmware for %d seconds\n", BOOT_DELAY / 1000000);
	
	/* Check if user wants to upload new firmware */
	switch (boot_select ())
	{
		/* No new frimware. Loading firmware from flash */
		case FLASH_BOOT:
			printf ("Flash boot. Starting boot from flash...\n");			
			break;
			
		/* New firmware incoming. Store it to flash */
		case SERIAL_BOOT:
			printf ("Serial boot. Attempting serial firmware loading...\n");
			serial_load_firmware (&fw);
			firmware_source = fw.payload;
			firmware_length = fw.length;			
			store_firmware (&fw, FLASH_BLOCK_OFFSET);
			break;
			
		/*  New firmware incoming but without erasing the previous */
		case SDRAM_BOOT:
			printf ("Sdram boot. Attempting serial firmware loading...\n");
			serial_load_firmware (&fw);
			firmware_source = fw.payload;
			firmware_length = fw.length;			
			break;
			
		default:
			printf ("Unknown command received. Halt!\n");
			for (;;);			
	}
	
	load_firmware ((uint32_t *) SDRAM_OFFSET, firmware_source, firmware_length >> 2 /* len in bytes to dwords */);

	/* Flush uart buffer */
	uart_force_sync (1);
	irq_enable (0);
	irq_setmask (0);
	
	goto *((uint32_t *) SDRAM_OFFSET);	
}
