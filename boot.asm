[org 0x7c00]

mov ax,3
int 0x10

xchg bx, bx
mov ax, 0
mov ss, ax
mov sp, 0x7c00


mov cx, 0
; call 0:func

mov word [0x80 * 4], intr
mov word [0x80 * 4 + 0x2], 0

mov word [0x0], div_err
mov word [0x2], 0

mov dx, 0
mov ax, 5
mov bx, 0
div bx

int 0x80

jmp halt


div_err:
    iret

intr:
    iret
func:
    retf
function:
    dw func, 0
halt:
    xchg bx, bx
    jmp halt

times 510 - ($ - $$) db 0
db 0x55, 0xaa