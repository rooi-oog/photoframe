#ifndef __HW_SYSCTL_H
#define __HW_SYSCTL_H

#include <hw/common.h>

#define CSR_GPIO_IN			MMPTR (0x30001000)
#define CSR_GPIO_OUT		MMPTR (0x30001004)
#define CSR_GPIO_INTEN		MMPTR (0x30001008)

#define CSR_TIMER0_CONTROL	MMPTR (0x30001010)
#define CSR_TIMER0_COMPARE	MMPTR (0x30001014)
#define CSR_TIMER0_COUNTER	MMPTR (0x30001018)
#define CSR_TIMER0_PWM		MMPTR (0x3000101C)

#define CSR_TIMER1_CONTROL	MMPTR (0x30001020)
#define CSR_TIMER1_COMPARE	MMPTR (0x30001024)
#define CSR_TIMER1_COUNTER	MMPTR (0x30001028)
#define CSR_TIMER1_PWM		MMPTR (0x3000102C)

#define TIMER_ENABLE		(0x01)
#define TIMER_AUTORESTART	(0x02)

/* This counter ticks every 1 us */
#define SIMPLE_COUNTER		MMPTR (0x30001050)

#define CSR_FREQUENCY		MMPTR (0x30001074)
#define CSR_SYSTEM_ID		MMPTR (0x3000107c)

#endif /* __HW_SYSCTL_H */