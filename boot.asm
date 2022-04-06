[org 0x7c00]

mov ax,3
int 0x10

xchg bx, bx

; mov ax, 5
; mov bx, 7

; mul bx ; dx : ax = bx * ax

; ;dx : ax / oper = ax(商) - dx(余)
; mov bx, 4
; div bx

clc
mov ax, [number1]
mov bx, [number2]

add ax, bx
mov [sum], ax

mov ax, [number1 + 2]
mov bx, [number2 + 2]
adc ax, bx

mov [sum + 2], ax

halt:
    jmp halt
number1:
    dd 0xcfff_ffff
number2:
    dd 4
sum:
    dd 0x0000_0000


times 510 - ($ - $$) db 0
db 0x55, 0xaa