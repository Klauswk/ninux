gdt_start:

gdt_null:
	dd 0x0
	dd 0x0

gdt_code_description:
	dw 0xFFFF
	dw 0x0
	db 0x0
	db 0b10011010
	db 0b11001111
	db 0x0

gdt_data_description:
	dw 0xFFFF
	dw 0x0
	db 0x0
	db 0b10010010
	db 0b11001111
	db 0x0
gdt_end:

gdt_descriptor:
	dw gdt_end - gdt_start - 1
	dd gdt_start
 	CODE_SEG equ gdt_code_description - gdt_start
	DATA_SEG equ gdt_data_description - gdt_start
