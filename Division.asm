section .data
    msg1 db "Enter dividend: ",0
    len1 equ $-msg1
    msg2 db "Enter divisor: ",0
    len2 equ $-msg2
    resmsg db "Quotient = ",0
    lenres equ $-resmsg
    newline db 10

section .bss
    num1 resb 16
    num2 resb 16
    outbuf resb 16

section .text
    global _start

_start:
    ; prompt dividend
    mov eax,4
    mov ebx,1
    mov ecx,msg1
    mov edx,len1
    int 0x80

    ; read dividend
    mov eax,3
    mov ebx,0
    mov ecx,num1
    mov edx,16
    int 0x80

    ; atoi inline for dividend
    xor eax,eax
    mov esi,num1
.d1: mov bl,[esi]
    cmp bl,'0'
    jb .d1done
    cmp bl,'9'
    ja .d1done
    sub bl,'0'
    imul eax,eax,10
    add eax,ebx
    inc esi
    jmp .d1
.d1done:
    push eax    ; save dividend

    ; prompt divisor
    mov eax,4
    mov ebx,1
    mov ecx,msg2
    mov edx,len2
    int 0x80

    ; read divisor
    mov eax,3
    mov ebx,0
    mov ecx,num2
    mov edx,16
    int 0x80

    ; atoi inline for divisor
    xor ebx,ebx
    mov esi,num2
.d2: mov dl,[esi]
    cmp dl,'0'
    jb .d2done
    cmp dl,'9'
    ja .d2done
    sub dl,'0'
    imul ebx,ebx,10
    add ebx,edx
    inc esi
    jmp .d2
.d2done:

    ; divide
    pop eax     ; dividend
    xor edx,edx
    div ebx     ; quotient in eax
    ; print message
    push eax
    mov eax,4
    mov ebx,1
    mov ecx,resmsg
    mov edx,lenres
    int 0x80
    pop eax

    ; itoa inline
    mov edi,outbuf
    mov ecx,0
.conv: xor edx,edx
    mov ebx,10
    div ebx
    add dl,'0'
    push edx
    inc ecx
    test eax,eax
    jnz .conv
    mov eax,ecx
    mov esi,edi
.writedigs:
    pop edx
    mov [esi],dl
    inc esi
    loop .writedigs
    mov byte [esi],0
    mov edx,eax

    ; print result
    mov eax,4
    mov ebx,1
    mov ecx,outbuf
    int 0x80

    ; newline
    mov eax,4
    mov ebx,1
    mov ecx,newline
    mov edx,1
    int 0x80
    ; exit
    mov eax,1
    xor ebx,ebx
    int 0x80
