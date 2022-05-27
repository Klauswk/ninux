CC=gcc
CCFLAGS=-m32 -ffreestanding

ASM=nasm

SRC_FOLDER=src
TARGET_FOLDER=target

SOURCE_FILES=${SRC_FOLDER}/vga/vga.c ${SRC_FOLDER}/string_utils/string_utils.c ${SRC_FOLDER}/main.c
ASM_FILES=${SRC_FOLDER}/boot.s
OBJ_FILES=$(patsubst src/*.c,${TARGET_FOLDER}/%.o,$(SOURCE_FILES)) 
BIN_FILES=$(patsubst src/*.s,${TARGET_FOLDER}/%.bin,$(ASM_FILES))

CFLAGS=-m32 -nostdlib -nostdinc -fno-builtin -fno-stack-protector -ffreestanding -Wall -Wextra
LDFLAGS=-T${SRC_FOLDER}/link.ld -m elf_i386
ASFLAGS=-f elf32

KERNEL_BIN=ninux.bin

all: ninux.bin 

create_target:
	mkdir -p target

clean:
	rm -rf target/

run: 
	qemu-system-i386 -kernel ${TARGET_FOLDER}/${KERNEL_BIN} -monitor stdio

${KERNEL_BIN}: ${OBJ_FILES} ${BIN_FILES}  
	ld ${LDFLAGS} -o ${TARGET_FOLDER}/%@ ${OBJ_FILES} ${BIN_FILES}

%.bin: %.s create_target 
	${ASM} ${ASFLAGS} $< -o ${TARGET_FOLDER}/%@


%.o: %.c create_target  
	${CC} ${CFLAGS} $< -c -o ${TARGET_FOLDER}/%@ 
	