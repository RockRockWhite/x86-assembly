[org 0x7c00]

mov ax,3
int 0x10

xchg bx, bx

CRT_ADDR_REG equ 0x3D4
CRT_DATA_RGU equ 0x3D5
CRT_CURSOR_HIGH equ 0x0E
CRT_CURSOR_LOW equ 0x0F

mov ax, 15 * 80
call set_cursor


xor ax, ax

mov dx, CRT_ADDR_REG
mov al, CRT_CURSOR_HIGH
out dx, al

mov dx, CRT_DATA_RGU
in al, dx
shl ax, 8


mov dx, CRT_ADDR_REG
mov al, CRT_CURSOR_LOW
out dx, al

mov dx, CRT_DATA_RGU
in al, dx
; mov ax, 0xb800
; mov es, ax

; mov si, message
; mov di, 0

; print:
;     mov bl, [si]

;     cmp bl, 0
;     jz print_end

;     mov [es:di], bl

;     inc si
;     add di, 2

;     jmp print
print_end:
halt:
    hlt ; 关闭cpu, 等待外中断
    jmp halt
message:
    db "Hello World!", 0
set_cursor: ; 设置光标位置函数, 参数用ax传递
    push dx
    push bx

    mov bx, ax

    mov dx, CRT_ADDR_REG
    mov al, CRT_CURSOR_LOW
    out dx, al
    mov dx, CRT_DATA_RGU
    mov al, bl
    out dx, al

    mov dx, CRT_ADDR_REG
    mov al, CRT_CURSOR_HIGH
    out dx, al
    mov dx, CRT_DATA_RGU
    mov al, bh
    out dx, al

    pop bx
    pop dx
    ret
times 510 - ($ - $$) db 0
db 0x55, 0xaa