
SRC_FOLDER="src/"
TARGET_FOLDER="target/"

all: clean target_folder bootloader

.PHONY: target_folder
target_folder:
	mkdir -p ${TARGET_FOLDER}

bootloader:
	nasm ${SRC_FOLDER}/bootloader/bootloader.asm -f bin -o ${TARGET_FOLDER}/bootloader.bin

	
run: bootloader
	qemu-system-i386 ${TARGET_FOLDER}/bootloader.bin

.PHONY: clean
clean:
	rmdir ${TARGET_FOLDER}
