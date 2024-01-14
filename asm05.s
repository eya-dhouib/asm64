section .text
    global _start

_start:
    ; Appel à execve
    asm01_path dq "./asm01"
    push asm01_path
    xor rsi, rsi
    xor rdx, rdx
    mov al, 59       ; 59 pour executer
    syscall

    cmp rax, rsi
    jl  error_exit

    mov al, 60
    xor rdi, rdi
    syscall

error_exit:
    mov al, 60
    xor rdi, rdi
    syscall

