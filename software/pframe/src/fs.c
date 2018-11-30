#include <stdio.h>
#include <stdlib.h>
#include <string.h>

#include "delay.h"
#include "fatfs/ff.h"
#include "fs.h"

static FATFS fs;
static FILINFO fileInfo;
static uint32_t file_offset;

void fs_mount (void)
{
	FRESULT res;

/* Mounting file system until it'll be mounted */		
__remount:
	if ((res = f_mount (&fs, "", 1 /* Force disk_initialize && mount */)) != FR_OK) {
		printf ("E: f_mount() failed, res = %d\n", res);
		delay_ms (4000);
		goto __remount;
	}
	
	printf ("I: SD card mounted successfully\n");	
}

void fs_unmount (void)
{
	f_unmount ("");
}

/*
 * Scans for all files on entire SD card 
 */
FRESULT fs_scan_files (
	GSList **list, 
	char *path			/* Start node to be scanned (***also used as work area***) */ , 
	char *pattern
)
{
	FRESULT res;
	DIR dir;
	UINT i;
	
	res = f_opendir (&dir, path);
	if (res == FR_OK) {
		for (;;) {
			res = f_readdir (&dir, &fileInfo);
			if (res != FR_OK || fileInfo.fname [0] == 0) break;
			if (fileInfo.fattrib & AM_DIR) {
				i = strlen (path);
                sprintf (&path[i], "/%s", fileInfo.fname);
                res = fs_scan_files (list, path, pattern);             /* Enter the directory */
                if (res != FR_OK) break;
                path [i] = 0;
			} else if (strncmp (&fileInfo.fname [strlen (fileInfo.fname) - 3], pattern, 3) == 0) {				
				char *filepath = malloc (strlen (path) + strlen (fileInfo.fname) + 1);
				sprintf (filepath, "%s/%s", path, fileInfo.fname);
				printf ("I: Found: %s\n", filepath);
				*list = g_slist_prepend (*list, filepath);
			}			
		}
		f_closedir(&dir);
	}
	
	return res;
}

/*
 * Wrapper for f_open
 */
FRESULT fs_open (FIL *fp, char *path)
{
	file_offset = 0;	/* Only one file can be simultaneously opened */
	return f_open (fp, path, FA_READ);
}

/*
 * Wrapper for f_close
 */
FRESULT fs_close (FIL *fp)
{
	return f_close (fp);
}

/*
 * Reads file and move file ponter towards
 */
FRESULT fs_read (FIL* fp, void* buff, UINT btr, UINT* br)
{
	FRESULT res;
	
	res = f_lseek (fp, file_offset);
	if (res == FR_OK) {
		res = f_read (fp, buff, btr, br);	
		if (res == FR_OK) {
			file_offset += btr;
		}		
	}
	
	return res;
}

/*
 * Moves file pointer towards from top
 */
FRESULT fs_lseek (FIL* fp, FSIZE_t ofs)
{
	file_offset += ofs;
	return f_lseek (fp, file_offset);
}

