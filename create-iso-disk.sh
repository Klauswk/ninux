mkdir -p isofiles/boot/grub/

echo "set timeout=0
set default=0

menuentry "myos" {
    multiboot2 /boot/kernel.bin
    boot
}" > isofiles/boot/grub/grub.cfg

cp target/kernel.bin isofiles/boot/kernel.bin

grub2-mkrescue -o os.iso isofiles