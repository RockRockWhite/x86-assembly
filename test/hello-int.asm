[bits 32]

section .text

global main
main:
    mov eax, 4 ;write
    mov ebx, 1 ;stdout
    mov ecx, message ;buffer
    mov edx, message_end - message ;length
    int 0x80

    mov eax, 1 ;exit
    mov ebx, 0 ;status
    int 0x80

section .data
    message: db "hello world", 0
    message_end: