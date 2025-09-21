section .data
    msg1 db "Enter first number: ",0
    l1 equ $-msg1
    msg2 db "Enter second number: ",0
    l2 equ $-msg2
    msg3 db "Subtraction = ",0
    l3 equ $-msg3
    minus db "-",0
    nl db 10

section .bss
    num1 resb 16
    num2 resb 16
    outbuf resb 16

section .text
    global _start

atoi:   ; ecx=buf → eax=int
    xor eax,eax
.next:  mov bl,[ecx]
    cmp bl,'0'     ; below '0'
    jb .done
    cmp bl,'9'     ; above '9'
    ja .done
    sub bl,'0'
    imul eax,eax,10
    add eax,ebx
    inc ecx
    jmp .next
.done:  ret

itoa:   ; eax=num, edi=buf
    mov ecx,0
.loop:  xor edx,edx
    mov ebx,10
    div ebx
    add dl,'0'
    push edx
    inc ecx
    test eax,eax
    jnz .loop
.w:     pop edx
    mov [edi],dl
    inc edi
    loop .w
    mov edx,edi
    sub edx,outbuf
    ret

_start:
    ; ---- prompt 1 ----
    mov eax,4; write
    mov ebx,1
    mov ecx,msg1
    mov edx,l1
    int 0x80
    ; read first
    mov eax,3
    mov ebx,0
    mov ecx,num1
    mov edx,16
    int 0x80
    mov ecx,num1
    call atoi
    push eax        ; save first

    ; ---- prompt 2 ----
    mov eax,4
    mov ebx,1
    mov ecx,msg2
    mov edx,l2
    int 0x80
    ; read second
    mov eax,3
    mov ebx,0
    mov ecx,num2
    mov edx,16
    int 0x80
    mov ecx,num2
    call atoi
    mov ebx,eax     ; second
    pop eax         ; first

    sub eax,ebx
    mov ecx,eax

    ; ---- print result label ----
    mov eax,4
    mov ebx,1
    mov ecx,msg3
    mov edx,l3
    int 0x80

    ; ---- handle sign ----
    cmp ecx,0
    jge .pos
    neg ecx
    mov eax,4
    mov ebx,1
    mov ecx,minus
    mov edx,1
    int 0x80
.pos:
    ; convert & print number
    mov eax,ecx
    mov edi,outbuf
    call itoa
    mov eax,4
    mov ebx,1
    mov ecx,outbuf
    int 0x80

    ; newline
    mov eax,4
    mov ebx,1
    mov ecx,nl
    mov edx,1
    int 0x80

    ; exit
    mov eax,1
    xor ebx,ebx
    int 0x80
