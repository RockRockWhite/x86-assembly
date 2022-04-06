%.bin: %.asm
	nasm $< -o $@
master.img: boot.bin
	dd if=boot.bin of=master.img bs=512 count=1 conv=notrunc
bochs: master.img
	bochs -q -unlock

.PHONY:clean
clean:
	rm -rf *.bin