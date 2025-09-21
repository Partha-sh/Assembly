1 section .text
2 global _start ;must be declared for linker (ld)
3
4 _start:
5
6 mov eax,x ;number bytes to be summed
7 mov ebx,0 ;EBX will store the sum
8 mov ecx, 5 ;ECX will point to the current element to be summed
9
10 top: add ebx, [eax]
11
12 add eax,1 ;move pointer to next element
13 ;decrement counter
14 loop top ;if counter not 0, then loop again
15
16 done:
17
18 add ebx, '0'
19 mov [sum], ebx ;done, store result in "sum"
20
21 display:
22
23 mov edx,1 ;message length
24 mov ecx, sum ;message to write
25 mov ebx, 1 ;file descriptor (stdout)
26 mov eax, 4 ;system call number (sys_write)
27 int 0x80 ;call kernel
28
29 mov eax, 1 ;system call number (sys_exit)
30 int 0x80 ;call kernel
31
32 section .data
33 global x
34 x:
35 db 1
36 db 2
37 db 3
38 db 1
39 db 2
40
41 sum:
42 db 0 , 0xa
