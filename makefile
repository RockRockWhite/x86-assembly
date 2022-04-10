build/%.bin: src/%.asm
	nasm $< -o $@

build/master.img: build/boot.bin build/loader.bin
ifeq ("$(wildcard build/master.img)", "")
	bximage -q -hd=16 -func=create -sectsize=512 -imgmode=flat $@
endif
	dd if=build/boot.bin of=$@ bs=512 count=1 conv=notrunc
	dd if=build/loader.bin of=$@ bs=512 count=4 seek=2 conv=notrunc

bochs: build/master.img
	cd build && bochs -q -unlock


.PHONY:clean
clean:
	rm -rf build/bx_enh_dbg.ini
	rm -rf build/*.bin
	rm -rf build/*.img