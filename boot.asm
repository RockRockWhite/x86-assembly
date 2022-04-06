[org 0x7c00]

mov ax,3
int 0x10

xchg bx, bx


start:
    ; jmp short start
    ; jmp near start
    jmp 0x0:0x7c00
; mov ax, 5
; mov bx, 7

; mul bx ; dx : ax = bx * ax

; ;dx : ax / oper = ax(商) - dx(余)
; mov bx, 4
; div bx

; 进位加
; clc
; mov ax, [number1]
; mov bx, [number2]

; add ax, bx
; mov [sum], ax

; mov ax, [number1 + 2]
; mov bx, [number2 + 2]
; adc ax, bx

; mov [sum + 2], ax

; 借位减
clc

mov ax, [number1]
mov bx, [number2]
sub ax, bx
mov [res], ax

mov ax, [number1 + 2]
mov bx, [number2 + 2]
sbb ax, bx
mov [res + 2], ax


halt:
    jmp halt
number1:
    dd 0x000c_0000
number2:
    dd 0x0000_ffff
res:
    dd 0x0000_0000


times 510 - ($ - $$) db 0
db 0x55, 0xaa