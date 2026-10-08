#ifndef _FAULT_TRIGGER_H_
#define _FAULT_TRIGGER_H_

__attribute__((noinline, used))
void trigger_busfault_read(void);

__attribute__((noinline, used))
void trigger_usage_div0(void);

#endif
