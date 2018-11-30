/* 
 * TODO:
 * 1. printf corrupts framebuffer!!!
 * 2. Something else corrupts framebuffer!!!
 * 3. Clearing vga_lastbuffer inside of jpeg_decode function corrupts framebuffer!!! WTF?!!
 * 4. Double check of wb_sdram_arbiter.v if it gives priority to the framebuffer!
 * 5. Replace RGB565 on YUV422 to store in memory in order to increase color depth.
 */
 
#include <stdio.h>
#include "hw/sysctl.h"
#include "hw/vga.h"
#include "hw/gpio.h"
#include "vga/vga.h"
#include "vga/backlight.h"
#include "uart/uart.h"
#include "irq.h"
#include "delay.h"
#include "fatfs/ff.h"
#include "fs.h"

static FIL fjpg;
static char path_buffer [512];
static GSList *images;
static uint8_t next_decor;

extern uint16_t *vga_frontbuffer;
extern uint16_t *vga_backbuffer;
extern uint16_t *vga_lastbuffer;

extern int jpeg_decode (FIL *, uint8_t *, uint16_t, uint16_t);

static void clean_framebuffer (uint16_t *fb)
{
	for (uint32_t i = 0; i < CSR_VGA_HRES * CSR_VGA_VRES; i++)
		*fb++ = 0;
}

static void copy_image (uint16_t *dest, uint16_t *src, uint8_t decor, uint16_t delay)
{
	uint16_t hres = CSR_VGA_HRES;
	uint16_t vres = CSR_VGA_VRES;
	
	switch (decor) 
	{
		/* From top to bottom */
		default:
		case 1: 
			for (uint32_t i = 0; i < hres * vres; i++) {
				*dest++ = *src++;
				delay_us (delay);
			}
			break;
		
		/* From bottom to top */
		case 3:
			for (uint32_t i = hres * vres; i > 0; i--) {
				dest [i - 1] = src [i - 1];
				delay_us (delay);
			}
			break;
			
		/* From left to right */
		case 0:
			for (uint16_t x = 0; x < hres; x++) {
				for (uint16_t y = 0; y < vres; y++) {
					dest [y * hres + x] = src [y * hres + x];
					//delay_us (delay);
				}
			}
			break;
			
		/* From right to left */
		case 2:
			for (uint16_t x = hres; x > 0; x--) {
				for (uint16_t y = 0; y < vres; y++) {
					dest [y * hres + x - 1] = src [y * hres + x - 1];
					//delay_us (delay);
				}
			}
			break;	
	}
}

static void decode_images_cb (void *path, void *unused)
{
	(void) unused;
	
	uint32_t start_time;
	
	if (fs_open (&fjpg, (char *) path) == FR_OK) 
	{		
		/* Ticks count at start of decoding */
		start_time = SIMPLE_COUNTER;
		
		/* Clear jpeg image buffer */
		clean_framebuffer (vga_lastbuffer);
		/* Decoding jpeg */
		jpeg_decode (&fjpg, (uint8_t *) vga_lastbuffer, CSR_VGA_HRES, CSR_VGA_VRES);
		/* Close jpeg file */
		fs_close (&fjpg);
		/* Copy image from jpeg buffer into display buffer with decoration :))) */			
		copy_image (vga_frontbuffer, vga_lastbuffer, next_decor, 1);
		/* Apply next decoration */
		next_decor = (next_decor + 1) & 3;
		
		/* Hold displayed image for 8s */
		/* XXX: What if image displaying would occupy more than 8s?!!! */
		delay_us (8000000U - (SIMPLE_COUNTER - start_time));		
	
	} else {
		printf ("Unable to open file %s\n", (char *) path);
		delay_ms (1000);
	}
}

int main (void)
{
	/* Turns all leds off */
	CSR_GPIO_OUT = 0;		
	/* Mask all interrupts */
	irq_setmask (0);	
	/* Global interrupt enable */
	irq_enable (1);		
	/* UART initialization */
	uart_init ();	
	/* Enable LCD backlight with 30% brightness */	
	backlight_init (30);	
	/* Enable VGA framebuffer */
	vga_init (0);
	/* Enter in vga console mode */
	vga_set_console (1);
	
	/* Mound SD card */
	/* TODO: Check for SD card is present */
	fs_mount ();
	
	/* Scan all files on SD card */
	fs_scan_files (&images, path_buffer, "jpg");
	
	/* Check if any image found */
	if (images == NULL) {
		printf ("W: unable to find any images on SD card!\n");
		/* TODO: Maybe inf. loop is not the best way... */
		for (;;);	
	}
	
	printf ("I: Start decoding images from last image...\n");
	
	/* Exit out of vga console mode */
	vga_set_console (0);
	
	/* Infinite cycle of displaying images */
	for (;;) {
		g_slist_foreach (images, decode_images_cb, NULL);
	}
	
	delay_ms (0);
	for (;;);
}
