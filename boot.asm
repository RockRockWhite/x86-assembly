[org 0x7c00]

mov ax,3
int 0x10

xchg bx, bx
mov ax, 0
mov ss, ax
mov sp, 0x7c00

push byte 2
push dword 7
push word 5

pop ax
pop bx
pop cx

halt:
    xchg bx, bx
    jmp halt
print:
    mov ax, 0xb800
    mov es, ax
    mov bx, [video]
    mov [es:bx], '.'
    dec word [video]
    ret
video:
    dw 0x0


times 510 - ($ - $$) db 0
db 0x55, 0xaa