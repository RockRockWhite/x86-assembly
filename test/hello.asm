[bits 32]

section .text
extern printf
extern exit
global main
main:
    push message
    call printf
    add esp, 4 ; 相当于pop

    push 0
    call exit

section .data
    message: db "hello world", 0
    message_end: