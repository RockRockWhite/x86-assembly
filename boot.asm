[org 0x7c00]

mov ax,3
int 0x10

xchg bx, bx

mov ax, 0x55aa
mov bx, 0xaa55
xor ax, bx
xor ax, ax ; ax 寄存器清空
mov ax, 0b1111_0010
test ax, 0b0000_0001

; 1111_0010
; 0011_1100_1000
; 0001_1110
; 0100_0000_0001_1110

shr ax, 5
ror ax, 5


halt:
    hlt ; 关闭cpu, 等待外中断
    jmp halt
data:
    dw 0x55aa

times 510 - ($ - $$) db 0
db 0x55, 0xaa