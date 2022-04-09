offset equ 0x0000
data equ 0x55aa


mov ax, 0x1000
mov ds, ax

mov ax, [offset]
mov [offset], ax

mov byte [offset], 0x10

; 只要有bp参与就默认ss, 否则ds
mov ax, [bx]
mov ax, [bp]
mov ax, [si]
mov ax, [di]

mov ax, [bx +si + offset]
mov ax, [bp +si + offset]
mov ax, [bp +di + offset]