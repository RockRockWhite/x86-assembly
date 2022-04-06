[org 0x7c00]

mov ax,3
int 0x10

xchg bx, bx

offset equ 0x0000
data equ 0x55aa


mov ax, 0x1000
mov ds, ax

mov ax, [offset]
mov [offset], ax

mov byte [offset], 0x10

; 只要有bp参与就默认ss, 否则ds
mov ax, [bx]
mov ax, [bp] ;ss
mov ax, [si]
mov ax, [di]

mov ax, [bx +si + offset]
mov ax, [bp +si + offset]
mov ax, [bp +di + offset]

; mov ax, 0xb800
; mov es, ax

; mov ax, 0
; mov ds, ax

; mov si, message
; mov di, 0

; mov cx, (message_end - message)

; loop1:
;     mov al, [ds:si]
;     mov [es:di], al

;     inc si
;     add di, 2

;     loop loop1

halt:
    jmp halt
; message:
;     db "hello, world", 0
; message_end:

times 510 - ($ - $$) db 0
db 0x55, 0xaa