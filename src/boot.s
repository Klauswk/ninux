MBALIGN  equ  1 << 0
MEMINFO  equ  1 << 1
FLAGS    equ  MBALIGN | MEMINFO
MAGIC    equ  0x1BADB002
CHECKSUM equ -(MAGIC + FLAGS)

section .multiboot
align 4
	dd MAGIC
	dd FLAGS
	dd CHECKSUM

section .bss
align 16
stack_bottom:
resb 16384 ; 16 KiB
stack_top:

section .text

%include "src/gdt.s"

global _start

_start:
	lgdt[gdt_descriptor]
	jmp CODE_SEG:start_protected_mode

[bits 32]
start_protected_mode:
	mov eax, cr0
	or eax, 1
	mov cr0, eax
	extern kmain
	call kmain
	cli
.hang:	hlt
	jmp .hang
