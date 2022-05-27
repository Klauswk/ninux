#ifndef SRC_VGA_H_
#define SRC_VGA_H_
#include "vga_color.h"
#include "../string_utils/string_utils.h"

void terminal_initialize(void);
void terminal_setcolor(unsigned short color);
void terminal_putentryat(char c, unsigned short color, unsigned int x, unsigned int y);
void terminal_putchar(char c);
void terminal_writestring(const char* data);

#endif /* SRC_VGA_H_ */
