#include "vga/vga.h"

void kmain(void)
{
	terminal_initialize();
	terminal_writestring("hello world!\nThis is a new line!");
}
