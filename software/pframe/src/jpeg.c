#include <stdint.h>
#include <stdlib.h>
#include <string.h>
#include <stdio.h>

#include "fs.h"
#include "tjpegd/tjpgd.h"

static uint16_t framebuffer_offset;

/* User defined session identifier */
typedef struct {
	FIL *fjpg;			/* Handle to input stream */
	BYTE *frmbuf;		/* Pointer to the frame buffer */
	DWORD wbyte;		/* Number of bytes a line of the frame buffer */
} IODEV;

static UINT jpeg_input_cb (
	JDEC* jd,		/* Decompression object */
	BYTE* buff,		/* Pointer to the read buffer (0:skip) */
	UINT ndata		/* Number of bytes to read/skip */
)
{
	UINT br;
	IODEV *dev = (IODEV *) jd->device;
	
	if (buff) {
		return fs_read (dev->fjpg, (BYTE *) buff, ndata, &br) == FR_OK ? br : 0;
	} else {
		return fs_lseek (dev->fjpg, ndata) == FR_OK ? ndata : 0;
	}
}

static UINT rgb_output_cb (
	JDEC* jd,		/* Decompression object */
	void* bitmap,	/* Bitmap data to be output */
	JRECT* rect		/* Rectangular region to output */
)
{	
	UINT ny, nbx, xc;
	DWORD wd;
	BYTE *src, *dst;
	IODEV *dev = (IODEV*)jd->device;
	
	nbx = (rect->right - rect->left + 1) * 2;	/* Number of bytes a line of the rectangular */
	ny = rect->bottom - rect->top + 1;			/* Number of lines of the rectangular */
	src = (BYTE*) bitmap;						/* RGB bitmap to be output */

	wd = dev->wbyte;							/* Number of bytes a line of the frame buffer */
	
	/* Left-top of the destination rectangular in the frame buffer */
	dst = dev->frmbuf + rect->top * wd + rect->left * 2 + framebuffer_offset;

	do {	/* Copy the rectangular to the frame buffer */
		xc = nbx;
		do {
			*dst++ = *src++;
		} while (--xc);
		dst += wd - nbx;
	} while (--ny);

	return 1;	/* Continue to decompress */
}

int jpeg_decode (FIL *fjpg, uint8_t *framebuffer, uint16_t hres, uint16_t vres) //uint16_t line_width)
{	
	/* Size of working buffer for TJDEC module */
	const size_t sz_work = 4096;	/* ChaN declares that minimum is 3071, but it isn't true */
	
	/* Working buffer for TJDEC module */
	void *jdwork;
	
	/* TJDEC decompression object */
	JDEC jd;
	
	/* Identifier of the decompression session (depends on application) */
	IODEV iodev;

	/* JPEG decode result */
	JRESULT ret;	
	
	/* JPEG file for decoding */
	iodev.fjpg = fjpg;
	
	/* Framebuffer pointer */
	iodev.frmbuf = framebuffer;	
	
	/* Byte width of the frame buffer */
	iodev.wbyte = (DWORD) hres * 2; //(DWORD) 1280 * 2;				
	
	/* Allocate a work area for TJDEC */
	jdwork = malloc (sz_work);											
	
	framebuffer_offset = 0;
	
	/* Prepare to decompress the file */
	if (!(ret = jd_prepare(&jd, jpeg_input_cb, jdwork, sz_work, &iodev))) {

	/* Place image at center of the screen */
		if (jd.width < hres) {
			framebuffer_offset = (hres - jd.width);
			/* Aiming in start of the pixel */
			if (framebuffer_offset % 2 != 0) framebuffer_offset++;
		}
			
		if (jd.height < vres)
			iodev.frmbuf += (vres - jd.height) * hres;
		
		/* Start to decompress */		
		ret = jd_decomp (&jd, rgb_output_cb, 0); 							
	}
				
	free (jdwork);
	
	return ret;
}
