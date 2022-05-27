CC=gcc
CCFLAGS=-m32 -ffreestanding

ASM=nasm

SRC_FOLDER=src/
TARGET_FOLDER=target/

OBJ_FILES=main.o vga.o string_utils.o 
BIN_FILES=boot.bin

CFLAGS=-m32 -nostdlib -nostdinc -fno-builtin -fno-stack-protector -ffreestanding -Wall -Wextra
LDFLAGS=-T${SRC_FOLDER}link.ld -m elf_i386
ASFLAGS=-f elf32

KERNEL_BIN=ninux.bin

all: ninux.bin 

create_target:
	mkdir -p target

clean:
	rm -rf target/

run: 
	qemu-system-i386 -kernel ${TARGET_FOLDER}${KERNEL_BIN} -monitor stdio

${KERNEL_BIN}: boot.bin vga.o main.o string_utils.o  
	ld ${LDFLAGS} -o ${TARGET_FOLDER}$@ ${TARGET_FOLDER}boot.bin ${TARGET_FOLDER}vga.o ${TARGET_FOLDER}main.o ${TARGET_FOLDER}string_utils.o

boot.bin:
	${ASM} ${ASFLAGS} ${SRC_FOLDER}boot.s -o ${TARGET_FOLDER}$@

main.o:
	${CC} ${CFLAGS} -c ${SRC_FOLDER}main.c -o ${TARGET_FOLDER}$@

vga.o:
	${CC} ${CFLAGS} -c ${SRC_FOLDER}vga/vga.c -o ${TARGET_FOLDER}$@

string_utils.o:
	${CC} ${CFLAGS} -c ${SRC_FOLDER}string_utils/string_utils.c -o ${TARGET_FOLDER}$@
	