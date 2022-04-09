[org 0x7c00]

mov ax,3
int 0x10

xchg bx, bx

PIC_M_CMD equ 0x20
PIC_M_DATA equ 0x21

; 注册中断函数
mov word [8 * 4], clock
mov word [8 * 4 + 2], 0
; OCW1写入屏蔽字
mov al, 0b1111_1110
out PIC_M_DATA, al
; 打开中断允许标志
sti; IF = 1 cli

loopa:
    mov al, 'A'
    mov bx, 5
    call blink
    jmp loopa

clock:
    push ax
    push bx

    mov al, 'C'
    mov bx, 4
    call blink
    xchg bx, bx

    ; OCW2写入0x20表示中断完成
    mov al, 0x20
    out PIC_M_CMD, al

    pop bx
    pop ax
    iret

blink: ; 将al中的值闪烁输出在bx位置
    push cx
    push es

    mov cx, 0xb800
    mov es, cx

    shl bx, 1

    ; 取出当前文本值
    mov dl, [es:bx]
    ; 比较
    cmp dl, ' '
    je .set_char
    jne .set_space

    .set_char:
        mov [es:bx], al
        jmp .done
    .set_space:
        mov byte [es:bx], ' '
        jmp .done
    .done:
        pop es
        pop cx

        ret

halt:
    hlt ; 关闭cpu, 等待外中断
    jmp halt

times 510 - ($ - $$) db 0
db 0x55, 0xaa