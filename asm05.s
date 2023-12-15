section .data
    asm01_path db "./asm01", 0

section .text
    global _start

_start:
    ; Appel à execve
    mov rdi, asm01_path  ; Pointeur vers le chemin du programme à exécuter
    mov rsi, 0
    mov rdx, 0
    mov rax, 59          ; 59 pour executer
    syscall


    cmp rax, 0
    jl  error_exit

    ; Fin du programme asm05
    mov rax, 60
    xor rdi, rdi
    syscall

error_exit:
    ; Gestion des erreurs (à personnaliser selon vos besoins)
    mov rax, 60
    xor rdi, rdi
    syscall
