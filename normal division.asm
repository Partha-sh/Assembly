
section .data 
    quotient db 0       ; to store quotient
    remainder db 0      ; to store remainder

section .text 
    global _start          

_start: 
    mov ax, 144      ; AX = 144
    mov bl, 12       ; BL = 12
    div bl           ; AL = 144 ÷ 12 = 12, AH = 0
    mov [quotient], al
    mov [remainder], ah

    mov eax, 1       ; sys_exit
    xor ebx, ebx
    int 0x80
