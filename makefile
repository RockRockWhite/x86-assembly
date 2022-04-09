build/%.bin: src/%.asm
	nasm $< -o $@
build/master.img: build/boot.bin
	dd if=build/boot.bin of=build/master.img bs=512 count=1 conv=notrunc
bochs: build/master.img
	cd build && bochs -q -unlock

.PHONY:clean
clean:
	rm -rf build/*.bin