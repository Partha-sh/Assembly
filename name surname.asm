global _start

section .data
	name db "Shivam",10
	len_name equ $ - name
	surname db "Pawaskar",10
	len_surname equ $ - surname	
	
section .text
	
_start:
	mov eax, 4		
	mov ebx, 1		
	mov ecx, name		
	mov edx, len_name
	int 0x80
	
	mov eax, 4		
	mov ebx, 1		
	mov ecx, surname	
	mov edx, len_surname
	int 0x80
	
	mov eax,1
	xor ebx, ebx
	int 0x80
