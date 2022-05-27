gdt_start:

gdt_null: //We always need an null value in the first slot
	dd 0x0
	dd 0x0 //the description table need 8 bits, so two double bytes (4 bits) = 8 bits

gdt_code_description: //the description table for the code segment
	dw 0xFFFF // Flat memory model
	dw 0x0  // Base ( bits 0 -15)
	db 0x0  // Base ( bits 16 -23)
	db 0x9A // 1 st flags , type flags
	db 0xCF // 2 nd flags , Limit ( bits 16 -19)
	db 0x0 // Base ( bits 24 -31)

gdt_data_description: //the description table for the data segment
	dw 0xffff // Flat memory model
	dw 0x0 // Base ( bits 0 -15)
	db 0x0 // Base ( bits 16 -23)
	db 0x92 // 1 st flags , type flags
	db 0xCF // 2 nd flags , Limit ( bits 16 -19)
	db 0x0 // Base ( bits 24 -31)
gdt_end:

// GDT descriptior
gdt_descriptor:
	dw gdt_end - gdt_start - 1
	dd gdt_start
 	CODE_SEG equ gdt_code - gdt_start
	DATA_SEG equ gdt_data - gdt_start
