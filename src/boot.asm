[org 0x7c00]

mov ax,3
int 0x10

xchg bx, bx

mov edi, 0x1000
mov bl, 4
mov ecx, 2
call read_disk

jmp 0:0x1000 ; 跳转到loader

read_disk:
    ; 读取硬盘
    ; ecx - 存储起始扇区位置
    ; bl - 存取扇区数量
    ; edi - 数据存储内存位置
    pushad ; 将8个通用寄存器都入栈

    mov dx, 0x1f2
    mov al, bl
    out dx, al ; 设置扇区位置

    mov al, cl
    inc dx ; 0x1f3
    out dx, al ; 起始扇区低八位

    shr ecx, 8
    mov al, cl
    inc dx ; 0x1f4
    out dx, al ; 起始扇区中八位

    shr ecx, 8
    mov al, cl
    inc dx ;0x1f5
    out dx, al ; 起始扇区高八位

    shr ecx, 8
    and ecx, 0b1111 ; 取出最后4位
    mov al, 0b1110_0000
    or al, cl
    inc dx ;0x1f6
    out dx, al ; 1100+起始扇区的最后4位

    inc dx ;0x1f7
    mov al, 0x20 ;读硬盘
    out dx, al

    ; 读取硬盘状态
    .check:
        nop
        nop
        nop ; 一点延迟

        in al, dx
        and al, 0b1000_1000
        cmp al, 0b0000_1000 ; 准备完毕
        jnz .check


    xor eax, eax ; 清空ax
    mov al, bl
    mov dx, 256 ; 计算总字数
    mul dx
    mov cx, ax

    mov dx, 0x1f0

    .readw:
        nop
        nop
        nop

        in ax, dx
        mov  [edi], ax

        add edi, 2
        loop .readw

    popad ; 将8个通用寄存器都推栈
    ret

times 510 - ($ - $$) db 0
db 0x55, 0xaa