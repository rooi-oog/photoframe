#include <stdint.h>
#include <hw/sysctl.h>
#include <vga/backlight.h>

#define	PWM_TIMER_CONTROL	CSR_TIMER0_CONTROL
#define PWM_TIMER_COMPARE	CSR_TIMER0_COMPARE
#define PWM_TIMER_PWM		CSR_TIMER0_PWM
#define	PWM_FREQ			25000	//Hz

static uint32_t pwm_max_value;

void backlight_init (uint8_t duty)
{
	pwm_max_value = CSR_FREQUENCY / PWM_FREQ;
	
	PWM_TIMER_COMPARE = pwm_max_value;
	backlight_set_brightness (duty);	
	PWM_TIMER_CONTROL = TIMER_ENABLE | TIMER_AUTORESTART;
}

void backlight_set_brightness (uint8_t duty)
{
	PWM_TIMER_PWM = pwm_max_value * duty / 100;
}

