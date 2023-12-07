section .data
    number db 0
    result db 0

section .text
    global _start

_start:
    mov rax, 0
    mov rdi, 0
    mov rsi, number
    mov rdx, 2
    syscall

    movzx rax, byte [number]
    sub rax, '0'

    test rax, 1
    jnz impair
pair:
    mov byte [result], '0'
    jmp afficher_result

impair:

    mov byte [result], '1'

afficher_result:

    mov rax, 1
    mov rdi, 1
    mov rsi, result
    mov rdx, 1
    syscall

exit:

    mov rax, 60          ; Appel système pour sys_exit
    xor rdi, rdi         ; Code de sortie 0
    syscall

