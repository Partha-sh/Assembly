section .data
    msg1 db "Enter first number: ",0
    len1 equ $-msg1
    msg2 db "Enter second number: ",0
    len2 equ $-msg2
    resultMsg db "Result = ",0
    lenRes equ $-resultMsg
    newline db 10

section .bss
    num1 resb 10
    num2 resb 10
    res  resb 10

section .text
    global _start

_start:
    ; Ask for first number
    mov eax, 4
    mov ebx, 1
    mov ecx, msg1
    mov edx, len1
    int 0x80

    ; Read input (up to 10 chars)
    mov eax, 3
    mov ebx, 0
    mov ecx, num1
    mov edx, 10
    int 0x80

    ; Convert num1 -> integer
    mov esi, num1
    call atoi
    mov ebx, eax          ; store first number in ebx

    ; Ask for second number
    mov eax, 4
    mov ebx, 1
    mov ecx, msg2
    mov edx, len2
    int 0x80

    ; Read input
    mov eax, 3
    mov ebx, 0
    mov ecx, num2
    mov edx, 10
    int 0x80

    ; Convert num2 -> integer
    mov esi, num2
    call atoi

    ; Add
    add eax, ebx          ; eax = num1 + num2

    ; Convert result back to string
    mov edi, res+10       ; point to end of buffer
    call itoa             ; eax -> string in res

    ; Print "Result = "
    mov eax, 4
    mov ebx, 1
    mov ecx, resultMsg
    mov edx, lenRes
    int 0x80

    ; Print result
    mov eax, 4
    mov ebx, 1
    mov ecx, edi
    mov edx, 10
    int 0x80

    ; Print newline
    mov eax, 4
    mov ebx, 1
    mov ecx, newline
    mov edx, 1
    int 0x80

    ; Exit
    mov eax, 1
    xor ebx, ebx
    int 0x80

; -------- Functions --------
; atoi: ASCII string -> integer
; esi = string address, eax = result
atoi:
    xor eax, eax
.next:
    mov bl, [esi]
    cmp bl, 10        ; newline?
    je .done
    sub bl, '0'
    imul eax, eax, 10
    add eax, ebx
    inc esi
    jmp .next
.done:
    ret

; itoa: integer (eax) -> string, edi = buffer end
; returns edi pointing to start of string
itoa:
    mov ecx, 10
    mov edx, 0
.loop:
    xor edx, edx
    div ecx
    add dl, '0'
    dec edi
    mov [edi], dl
    test eax, eax
    jnz .loop
    ret
