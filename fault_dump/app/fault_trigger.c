#include <stdint.h>
#include <stdio.h>

#include "stm32f1xx_hal.h"
#include "core_cm3.h"

__attribute__((noinline, used))
void trigger_busfault_read(void)
{
    volatile uint32_t dummy;
    dummy = *(volatile uint32_t *)0xDEADBEEC;
    (void)dummy;
}

__attribute__((noinline, used))
void trigger_usage_div0(void)
{
    volatile int a = 10;
    volatile int b = 0;
    volatile int c = a / b;
    (void)c;
}
