bits 64

section .text
global _start

_start:
    ;push 0x37333331
    mov r15, 0x0a37333331
    push r15

    mov al, 1
    mov dil, 1
    mov rsi, rsp
    mov dl, 8
    syscall

    mov al, 60
    xor dil, dil ; xor rdi, rdi ; mov rdi, 0
    syscall
