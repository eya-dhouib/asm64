;section .data
   ; msg db '1337', 10
bits 64

section .text
global _start
_start:
    mov r15, 0x0a37333331
    push r15
    mov al, 1
    mov dil, 1
    mov rsi, rsp
    mov dl, 8
    syscall
    mov al, 60
    xor dil, dil
    syscall

