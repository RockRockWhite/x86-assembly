[org 0x7c00]

mov ax,3
int 0x10

xchg bx, bx

mov ax, 0
mov cx, 100
start:
    add ax, cx
    dec cx
    jz halt
    jmp start
    ; loop start

halt:
    xchg bx, bx
    jmp halt

times 510 - ($ - $$) db 0
db 0x55, 0xaa