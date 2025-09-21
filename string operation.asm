global _start

section .text
_start:
    cld                 ; clear direction flag (process forward)
    mov ecx, len        ; counter = string length
    mov esi, s1         ; source string
    mov edi, s2         ; destination string

loop_here:
    lodsb               ; load byte from [esi] into AL
    or al, 20h          ; convert uppercase to lowercase (ASCII trick)
    stosb               ; store AL into [edi]
    loop loop_here      ; repeat ECX times

    ; print result
    mov edx, len        ; message length (not hardcoded 20)
    mov ecx, s2         ; message to write
    mov ebx, 1          ; file descriptor (stdout)
    mov eax, 4          ; system call (sys_write)
    int 0x80

    ; exit
    mov eax, 1          ; sys_exit
    xor ebx, ebx        ; return 0
    int 0x80

section .data
s1 db 'HELLO, WORLD', 0xa  ; source string with newline
len equ $-s1               ; string length

section .bss
s2 resb len                ; reserve same size as s1
