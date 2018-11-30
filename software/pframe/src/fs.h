#ifndef __FS___H
#define __FS___H

#include "fatfs/ff.h"
#include "list.h"

void fs_mount (void);
void fs_unmount (void);
FRESULT fs_scan_files (GSList **list, char *path, char *pattern);
FRESULT fs_open (FIL *fp, char *path);
FRESULT fs_close (FIL *fp);
FRESULT fs_read (FIL* fp, void* buff, UINT btr, UINT* br);
FRESULT fs_lseek (FIL* fp, FSIZE_t ofs);

#endif /* __FS___H */

