section .data
    msg1 db "Enter first number: ",0
    len1 equ $-msg1
    msg2 db "Enter second number: ",0
    len2 equ $-msg2
    resmsg db "Multiplication = ",0
    lenres equ $-resmsg
    newline db 10

section .bss
    num1 resb 16
    num2 resb 16
    outbuf resb 16

section .text
    global _start

; --- atoi: ECX=buffer, returns EAX=int ---
atoi:
    xor eax, eax
.next:
    mov bl, [ecx]
    cmp bl, '0'
    jb .done
    cmp bl, '9'
    ja .done
    sub bl, '0'
    imul eax, eax, 10
    add eax, ebx
    inc ecx
    jmp .next
.done:
    ret

; --- itoa: EAX=number, EDI=buffer, returns length in EAX ---
itoa:
    mov ebx, 10
    xor ecx, ecx        ; digit count
.loop:
    xor edx, edx
    div ebx             ; EAX/10, remainder in EDX
    add dl, '0'
    push edx
    inc ecx
    test eax, eax
    jnz .loop
    mov eax, ecx        ; length
    mov esi, edi
.poploop:
    pop edx
    mov [esi], dl
    inc esi
    loop .poploop
    mov byte [esi], 0
    ret

; --- main ---
_start:
    ; prompt 1
    mov eax,4;write
    mov ebx,1
    mov ecx,msg1
    mov edx,len1
    int 0x80

    ; read num1
    mov eax,3
    mov ebx,0
    mov ecx,num1
    mov edx,16
    int 0x80

    ; prompt 2
    mov eax,4
    mov ebx,1
    mov ecx,msg2
    mov edx,len2
    int 0x80

    ; read num2
    mov eax,3
    mov ebx,0
    mov ecx,num2
    mov edx,16
    int 0x80

    ; convert numbers
    mov ecx,num1
    call atoi
    push eax
    mov ecx,num2
    call atoi
    mov ebx,eax
    pop eax

    imul eax, ebx       ; multiply

    ; print "Multiplication = "
    push eax
    mov eax,4
    mov ebx,1
    mov ecx,resmsg
    mov edx,lenres
    int 0x80
    pop eax

    ; convert result to string
    mov edi,outbuf
    call itoa
    mov edx,eax         ; length

    ; print result
    mov eax,4
    mov ebx,1
    mov ecx,outbuf
    int 0x80

    ; print newline
    mov eax,4
    mov ebx,1
    mov ecx,newline
    mov edx,1
    int 0x80

    ; exit
    mov eax,1
    xor ebx,ebx
    int 0x80
