#include "console.h"
#include "stm32f1xx_hal.h"

extern UART_HandleTypeDef huart1;

void console_output(const char *s) {
    if (!s)
        return;

    while (*s) {
        HAL_UART_Transmit(&huart1, (uint8_t *)s, 1, HAL_MAX_DELAY);
        s++;
    }
}

void console_line(const char *s) {
    console_output(s);
    console_output("\r\n");
}

static void console_output_hex(uint8_t byte) {
    static const char hex[] = "0123456789ABCDEF";
    char buf[3];

    buf[0] = hex[(byte >> 4) & 0x0F];
    buf[1] = hex[byte & 0x0F];
    buf[2] = '\0';

    console_output(buf);
}

void console_output_hexbuf(const uint8_t *data, uint16_t len) {
    if (!data || len == 0)
        return;

    for (uint16_t i = 0; i < len; i++) {
        console_output_hex(data[i]);

        if ((i + 1) % 16 == 0) {
            console_output("\r\n");
        } else {
            HAL_UART_Transmit(&huart1, (uint8_t *)" ", 1, HAL_MAX_DELAY);
        }
    }

    console_output("\r\n");
}

int __io_putchar(int ch) {
    HAL_UART_Transmit(&huart1, (uint8_t *)&ch, 1, HAL_MAX_DELAY);
    return ch;
}