[org 0x7c00]

mov ax,3
int 0x10

xchg bx, bx
mov ax, 0
mov ss, ax
mov sp, 0x7c00

push word 0xaabb
push word 0xccdd
push dword 0xeeffaabb

pop ax
pop bx
pop cx

halt:
    xchg bx, bx
    jmp halt

times 510 - ($ - $$) db 0
db 0x55, 0xaa