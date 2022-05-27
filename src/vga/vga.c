#include "vga.h"

static const unsigned int VGA_WIDTH = 80;
static const unsigned int VGA_HEIGHT = 25;

unsigned int terminal_row = 0;
unsigned int terminal_column = 0;
unsigned short terminal_color;
unsigned int* terminal_buffer;

static inline unsigned short vga_entry_color(enum vga_color fg, enum vga_color bg)
{
	return fg | bg << 4;
}

static inline unsigned int vga_entry(unsigned char uc, unsigned short color)
{
	return (unsigned int) uc | (unsigned int) color << 8;
}

void terminal_initialize(void)
{
	terminal_row = 0;
	terminal_column = 0;
	terminal_color = vga_entry_color(VGA_COLOR_LIGHT_GREY, VGA_COLOR_BLACK);
	terminal_buffer = (unsigned int*) 0xB8000;
	unsigned int index = 0;
	for (unsigned int y = 0; y < VGA_HEIGHT; y++) {
		for (unsigned int x = 0; x < VGA_WIDTH; x++) {
			index = y * VGA_WIDTH + x;
			terminal_buffer[index] = vga_entry(' ', terminal_color);
		}
	}
}

void terminal_setcolor(unsigned short color)
{
	terminal_color = color;
}

void terminal_putentryat(char c, unsigned short color, unsigned int x, unsigned int y)
{
	const unsigned int index = y * VGA_WIDTH + x;
	terminal_buffer[index] = vga_entry(c, color);
}

void terminal_putchar(char c)
{
	if(c == '\n') {
		++terminal_row;
		terminal_column = 0;
	} else {
		terminal_putentryat(c, terminal_color, terminal_column, terminal_row);
	}
	if (++terminal_column == VGA_WIDTH) {
		terminal_column = 0;
		if (++terminal_row == VGA_HEIGHT)
			terminal_row = 0;
	}
}

void terminal_write(const char* data, unsigned int size)
{
	for (unsigned int i = 0; i < size; i++)
		terminal_putchar(data[i]);
}

void terminal_writestring(const char* data)
{
	terminal_write(data, strlen(data));
}
