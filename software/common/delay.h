#ifndef _DELAY_H
#define _DELAY_H

#include "hw/sysctl.h"

static void delay_us (uint32_t us)
{	
	register uint32_t dtime = SIMPLE_COUNTER + us;
	while (SIMPLE_COUNTER < dtime);
}

static void delay_ms (uint32_t ms)
{		
	delay_us (ms * 1000);
}

#endif /* _DELAY_H */

