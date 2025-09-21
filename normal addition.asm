section .data 
    result db 0       ; to store addition result

section .text 
    global _start          

_start: 
    mov al, 50       ; load first number into AL
    add al, 30       ; add second number to AL
    mov [result], al ; store the result (80) in memory

    mov eax, 1       ; sys_exit system call
    xor ebx, ebx     ; return 0
    int 0x80
