#include <stdio.h>
#include <stdlib.h>

int main (int argc, char *argv[])
{
	FILE *fin = fopen (argv [1], "r");
	FILE *fout = fopen (argv [2], "w+");
	
	if (!fin || !fout) {
		fprintf (stderr, "Unable to open %d or %d\n", argv [1], argv [2]);
		exit (EXIT_FAILURE);
	}
	
	fseek (fin, 0L, SEEK_END);
	size_t fsz = ftell (fin);
	fseek (fin, 0L, SEEK_SET);
	
	unsigned char byte;
	int i = 0;
	
	fprintf (fout, 
		"#ifndef __BINARRAY\n"
		"#define __BINARRAY\n\n"
		"static const uint32_t file_size = %d;\n"
		"static const char file_data [%d] = {\n", fsz, fsz);
		
	while (1) {
		fread (&byte, 1, 1, fin);
		if (feof (fin))
			break;
		fprintf (fout, "0x%02X", byte);
		fprintf (fout, ", ");
		if (i % 18 == 0) fprintf (fout, "\n");
		i++;
	}
	
	fprintf (fout, 
		"};\n\n"
		"#endif /* __BINARRAY */");
	
	fclose (fin);
	fclose (fout);
		
	exit (EXIT_SUCCESS);
}
