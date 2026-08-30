#ifndef _CONSOLE_H_
#define _CONSOLE_H_

#include <stdint.h>

void console_output(const char *s);
void console_line(const char *s);
void console_output_hexbuf(const uint8_t *data, uint16_t len);

#endif
