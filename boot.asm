[org 0x7c00]

mov ax,3
int 0x10

xchg bx, bx

CRT_ADDR_REG equ 0x3D4
CRT_DATA_RGU equ 0x3D5
CRT_CURSOR_HIGH equ 0x0E
CRT_CURSOR_LOW equ 0x0F

mov ax, message
call print

xor ax, ax


halt:
    hlt ; 关闭cpu, 等待外中断
    jmp halt
message:
    db "Hello World!", 0
get_cursor: ; 获得光标位置, 参数用ax返回
    push dx

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

    pop dx

    ret
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
print: ;将ax寄存器地址指向的字符输出
    mov si, ax

    mov ax, 0xb800
    mov es, ax
print_loop:
    push bx

    call get_cursor
    mov di, ax
    shl di, 1

    mov bl, [si]
    cmp bl, 0
    je print_end

    mov [es:di], bl

    inc si
    inc ax

    call set_cursor

    jmp print_loop
print_end:
    pop bx
    ret








; print_end: ;将ax寄存器地址中的字符输出
;     push dx
;     push bx

;     mov si, ax

;     mov ax, 0xb800
;     mov es, ax

; loop:
;     call get_cursor
;     mov di, ax
;     shl di, 1

;     mov bl, [si]
;     cmp bl, 0
;     je end_loop

;     mov [es:di], bl

;     inc si
;     inc ax
;     call set_cursor

;     jmp loop
; end_loop:
;     pop bx
;     pop dx
;     ret
times 510 - ($ - $$) db 0
db 0x55, 0xaa