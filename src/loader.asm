[org 0x1000]

xchg bx, bx;
mov ax, 0xb800
mov es, ax
mov di, 0
mov byte [es:di], 'H'

xchg bx, bx
jmp $
