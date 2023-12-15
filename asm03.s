section .data
    pointeur dd '1337', 10
section .bss
    receveur resb 4;
section .text
    global _start

_start:
    mov rax, 0
    mov rdi, 0
    mov rsi, receveur
    mov rdx, 4
    syscall

    cmp byte [receveur], 0x34
    je _1337

    mov rax, 60
    mov rdi, 1
    syscall
_1337:

    mov rax, 1
    mov rdi, 1
    mov rsi, pointeur
    mov rdx, 5
    syscall 


    mov rax, 60
    mov rdi, 0
    syscall
