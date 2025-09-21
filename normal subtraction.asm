section .data
    result db 0             ; store result here

section .bss

section .text
    global _start
_start:

    ; Put values into registers
    mov eax, 50             ; EAX = 50
    mov ebx, 30             ; EBX = 30

    ; Subtraction
    sub eax, ebx            ; EAX = EAX - EBX (50 - 30 = 20)

    ; Store only the lowest byte of result (20 fits in 1 byte)
    mov [result], al        

    ; Exit syscall
    mov eax, 1
    xor ebx, ebx
    int 0x80
