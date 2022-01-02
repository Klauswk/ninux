
loop:
    jmp loop
    
times 510-($-$$) db 0 ; we need precisely 512 bytes for the boot sector, and also end with xAA55 (Last two bytes) for the identify this is a bootsector. This times function is for padding.

dw 0xaa55
