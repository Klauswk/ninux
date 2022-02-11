
SRC_FOLDER=src
TARGET_FOLDER=target
SOURCES=boot.o main.o

CFLAGS=-nostdlib -nostdinc -fno-builtin -fno-stack-protector -ffreestanding -Wall -Wextra
LDFLAGS=-T${SRC_FOLDER}/link.ld -ffreestanding -nostdlib
ASFLAGS=--32

all: $(SOURCES) link 

create_target:
	mkdir -p target

clean:
	rm -rf target/

run: 
	qemu-system-i386 -kernel target/kernel.bin 

link: create_target
	gcc $(LDFLAGS) -m32 -o ${TARGET_FOLDER}/kernel.bin ${TARGET_FOLDER}/boot.o ${TARGET_FOLDER}/main.o

boot.o: create_target
	as ${ASFLAGS} ${SRC_FOLDER}/boot.s -o ${TARGET_FOLDER}/boot.o

main.o: create_target 
	gcc ${CFLAGS} -m32 -lgcc ${SRC_FOLDER}/main.c -c -o ${TARGET_FOLDER}/main.o 
	