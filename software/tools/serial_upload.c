#include <string.h>
#include <stdlib.h>
#include <fcntl.h>
#include <termios.h>
#include <unistd.h>
#include <errno.h>
#include <stdio.h>

#define TTY_SPEED	B115200

static int tty_open (char *port) 
{
	int ttyfd;
	struct termios options;

	if ((ttyfd = open (port, O_RDWR | O_NOCTTY | O_NONBLOCK)) < 0)
	{
		char err [64]; sprintf (err, "Unable to open port %s", port);
		perror (err);
		exit (EXIT_FAILURE);
	}

	tcgetattr (ttyfd, &options);

	// set baud rate
	cfsetispeed (&options, TTY_SPEED);
	cfsetospeed (&options, TTY_SPEED);

	options.c_cflag |= CLOCAL | CREAD;						// enable the receiver and set local mode
	options.c_cflag &= ~CSIZE;								// mask the character size bits
	options.c_cflag |= CS8;									// select 8 data bits
	options.c_cflag &= ~PARENB;								// disable the parity check
	options.c_cflag &= ~CSTOPB;								// 1 stop bit
	options.c_cflag &= ~CRTSCTS;								// disable hardware flow control
	options.c_iflag &= ~(IXON | IXOFF | IXANY | 
		IGNBRK | INLCR | ICRNL);							// disable software flow control
	options.c_lflag &= ~(ICANON | ECHO | ECHOE | ISIG);		// select raw input
	options.c_oflag &= ~OPOST;								// select raw output

	// set the new options for the port
	tcsetattr (ttyfd, TCSAFLUSH, &options);
	
	return ttyfd;
}

static void tty_close (int ttyfd)
{
	close (ttyfd);
}

int main (int argc, char *argv[])
{
	FILE *fbin;
	FILE *fout;
	int ttyfd;
	int fsize;
	char buf;
	
	if (argc < 4) {
		printf ("Usage: %s command filename ttyport\n"
				"commands:\n"				
					"\t17 - store new firmware\n"				
					"\t34 - load firmware direct to sdram\n", argv [0]);
		exit (EXIT_FAILURE);
	}
	
	unsigned char cmd = atoi (argv [1]);
	
	if ((fbin = fopen (argv [2], "r")) == NULL)	{
		perror ("Unable to open file");
		exit (EXIT_FAILURE);
	}
	
	if ((ttyfd = tty_open (argv [3])) <= 0) {
		perror ("Unable to open tty");
		exit (EXIT_FAILURE);
	}
	
	fseek (fbin, 0L, SEEK_END);
	fsize = ftell(fbin);
	fseek (fbin, 0L, SEEK_SET);
	
	printf ("file size: %d bytes\n", fsize);
	
	write (ttyfd, &cmd, 1);
	write (ttyfd, &((char *) &fsize) [3], 1);
	write (ttyfd, &((char *) &fsize) [2], 1);
	write (ttyfd, &((char *) &fsize) [1], 1);
	write (ttyfd, &((char *) &fsize) [0], 1);
	
	for (int i = 0; i < fsize; i++) {
		fread (&buf, 1, 1, fbin);
		write (ttyfd, &buf, 1);
		usleep (100);
	}	
	
	tty_close (ttyfd);
	fclose (fbin);
	
	return 0;
}
