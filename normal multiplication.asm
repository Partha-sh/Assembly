section .data 

    result dw 0      ; 16-bit result storage

section .text 
    global _start          

_start: 
    mov al, 12       ; AL = 12
    mov bl, 15       ; BL = 15
    mul bl           ; AX = AL * BL → 180
    mov [result], ax ; store result (180)

    mov eax, 1       ; sys_exit
    xor ebx, ebx
    int 0x80
