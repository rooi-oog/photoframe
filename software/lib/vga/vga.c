/*
 * Milkymist SoC (Software)
 * Copyright (C) 2007, 2008, 2009, 2010, 2011 Sebastien Bourdeauducq
 *
 * This program is free software: you can redistribute it and/or modify
 * it under the terms of the GNU General Public License as published by
 * the Free Software Foundation, version 3 of the License.
 *
 * This program is distributed in the hope that it will be useful,
 * but WITHOUT ANY WARRANTY; without even the implied warranty of
 * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
 * GNU General Public License for more details.
 *
 * You should have received a copy of the GNU General Public License
 * along with this program.  If not, see <http://www.gnu.org/licenses/>.
 */
#include <stdint.h>
#include <string.h>

#include <hw/vga.h>
#include <vga/vga.h>
#include <vga/console.h>

extern const unsigned char fontdata_8x16 [];
#define FONT_HEIGHT 16
#define FONT_WIDTH  8

#define MAKERGB565N(r, g, b) ((((r) & 0xf8) << 8) | (((g) & 0xfc) << 3) | (((b) & 0xf8) >> 3))

/*
 * RGB565 framebuffers.
 */
static uint16_t framebufferA [1280 * 800] __attribute__((aligned(8)));
static uint16_t framebufferB [1280 * 800] __attribute__((aligned(8)));
static uint16_t framebufferC [1280 * 800] __attribute__((aligned(8)));

int vga_blanked;
int vga_hres;
int vga_vres;

uint16_t *vga_frontbuffer; /* < buffer currently displayed */
uint16_t *vga_backbuffer;  /* < buffer currently drawn */
uint16_t *vga_lastbuffer;  /* < buffer currently decode images */

/* Text mode framebuffer */
static uint16_t framebuffer_text [1280 * 800] __attribute__((aligned(8)));
static uint32_t cursor_pos;
static uint32_t text_line_len;
static int console_mode;

static int escape_mode;
static int highlight;

static void write_hook(char c);

void vga_init (int blanked)
{
	vga_blanked = blanked;

	vga_frontbuffer = framebufferA;
	vga_backbuffer  = framebufferB;
	vga_lastbuffer  = framebufferC;

	CSR_VGA_BASEADDRESS = (uint32_t) vga_frontbuffer;

	vga_set_mode(VGA_MODE_1280_800);
	console_set_write_hook (write_hook);
}

void vga_blank (void)
{
	if (!vga_blanked) {
		CSR_VGA_RESET = VGA_RESET;
		vga_blanked = 1;
	}
}

void vga_unblank (void)
{
	if (vga_blanked) {
		CSR_VGA_RESET = 0;
		vga_blanked = 0;
	}
}

void vga_swap_buffers (void)
{
	uint16_t *ptr;

	if (!console_mode && !vga_blanked) {
		/*
		 * Make sure last buffer swap has been executed.
		 */
		while (CSR_VGA_BASEADDRESS_ACT != CSR_VGA_BASEADDRESS);
	}

	ptr = vga_frontbuffer;
	vga_frontbuffer = vga_backbuffer;
	vga_backbuffer = ptr;
	
	if (!console_mode)
		CSR_VGA_BASEADDRESS = (uint32_t) vga_frontbuffer;
}

void vga_set_console (int console)
{
	console_mode = console;
	
	if (console)
		CSR_VGA_BASEADDRESS = (uint32_t) framebuffer_text;
	else
		CSR_VGA_BASEADDRESS = (uint32_t) vga_frontbuffer;
}

int vga_get_console(void)
{
	return console_mode;
}

/* http://web.mit.edu/6.111/www/s2004/NEWKIT/vga.shtml */
void vga_set_mode(int mode)
{
	CSR_VGA_RESET = VGA_RESET;
	switch(mode) {
		case VGA_MODE_640_480: // Pixel clock: 25MHz
			vga_hres = 640;
			vga_vres = 480;
			CSR_VGA_HRES = 640;
			CSR_VGA_HSYNC_START = 656;
			CSR_VGA_HSYNC_END = 752;
			CSR_VGA_HSCAN = 799;
			CSR_VGA_VRES = 480;
			CSR_VGA_VSYNC_START = 492;
			CSR_VGA_VSYNC_END = 494;
			CSR_VGA_VSCAN = 524;
			CSR_VGA_CLKSEL = 0;
			break;
			
		case VGA_MODE_800_600: // Pixel clock: 50MHz
			vga_hres = 800;
			vga_vres = 600;
			CSR_VGA_HRES = 800;
			CSR_VGA_HSYNC_START = 848;
			CSR_VGA_HSYNC_END = 976;
			CSR_VGA_HSCAN = 1040;
			CSR_VGA_VRES = 600;
			CSR_VGA_VSYNC_START = 636;
			CSR_VGA_VSYNC_END = 642;
			CSR_VGA_VSCAN = 665;
			CSR_VGA_CLKSEL = 1;
			break;
			
		case VGA_MODE_1024_768: // Pixel clock: 65MHz
			vga_hres = 1024;
			vga_vres = 768;
			CSR_VGA_HRES = 1024;
			CSR_VGA_HSYNC_START = 1048;
			CSR_VGA_HSYNC_END = 1184;
			CSR_VGA_HSCAN = 1344;
			CSR_VGA_VRES = 768;
			CSR_VGA_VSYNC_START = 772;
			CSR_VGA_VSYNC_END = 778;
			CSR_VGA_VSCAN = 807;
			CSR_VGA_CLKSEL = 2;
			break;
			
		case VGA_MODE_1280_800:	// Pixel clock: 50MHz
			vga_hres = 1280;
			vga_vres = 800;
			CSR_VGA_HRES = 1280;
			CSR_VGA_HSYNC_START = 1280;
			CSR_VGA_HSYNC_END = 1440;
			CSR_VGA_HSCAN = 1440;
			CSR_VGA_VRES = 800;
			CSR_VGA_VSYNC_START = 800;
			CSR_VGA_VSYNC_END = 823;
			CSR_VGA_VSCAN = 823;
			CSR_VGA_CLKSEL = 1;
			break;
	}
	
	memset (framebufferA, 0, vga_hres * vga_vres * 2);
	memset (framebufferB, 0, vga_hres * vga_vres * 2);
	memset (framebuffer_text, 0, vga_hres * vga_vres * 2);
	
	cursor_pos = 0;
	text_line_len = vga_hres / FONT_WIDTH;
	CSR_VGA_BURST_COUNT = (vga_hres * vga_vres) >> 1;

	if (!vga_blanked)
		CSR_VGA_RESET = 0;
}

static void bitblit (uint16_t fg, int x, int y, const uint8_t *origin)
{
	int dx, dy;
	uint16_t line;
	int fbi;

	for (dy = 0; dy < FONT_HEIGHT; dy++) {
		line = origin [dy];
		fbi = vga_hres * (y + dy) + x;
		for (dx = 7; dx >= 0; dx--) {
			framebuffer_text [fbi+dx] = (line & 0x0001) * fg;
			line >>= 1;
		}
	}
}

static void scroll (void)
{
	/* Software fallback */
	/* WARNING: may not work with all memcpy's! */
	memcpy(framebuffer_text, 
		framebuffer_text + vga_hres * FONT_HEIGHT, 2 * vga_hres * (vga_vres - FONT_HEIGHT));
	memset (framebuffer_text + vga_hres * (vga_vres - FONT_HEIGHT), 0, 2 * vga_hres * FONT_HEIGHT);
	cursor_pos = 0;
}

static void raw_print (char c, unsigned short int fg)
{
/*	unsigned char c2 = (unsigned char)c;*/
/*	unsigned int c3 = c2;*/
	
	uint32_t c32 = (uint32_t) ((uint8_t) c);
	
	bitblit (fg, cursor_pos * 8, vga_vres - FONT_HEIGHT, fontdata_8x16 + c32 * FONT_HEIGHT);
}

static void write_hook(char c)
{
	unsigned short int color;
	
	if (escape_mode) {
		switch (c) {
			case '1':
				highlight = 1;
				break;
			case '0':
				highlight = 0;
				break;
			case 'm':
			case '\n':
				escape_mode = 0;
				break;
			default:
				break;
		}
	} else {
		if (c == '\n') {
			raw_print (' ', MAKERGB565N (192, 192, 192));
			scroll ();
		} else if (c == 0x08) {
			if (cursor_pos > 0) {
				raw_print(' ', MAKERGB565N (192, 192, 192));
				cursor_pos--;
			}
		}
		else if (c == '\e')
			escape_mode = 1;
		else {
			color = highlight ? MAKERGB565N(255, 255, 255) : MAKERGB565N(192, 192, 192);
			raw_print (c, color);
			cursor_pos++;
			if (cursor_pos >= (text_line_len - 1))
				scroll();
		}
	}
}
