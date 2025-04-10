%macro writesystem 2
    	mov eax, 4
    	mov ebx, 1
    	mov ecx, %1
    	mov edx, %2
    	int 80h
%endmacro

%macro readsystem 2
    	mov eax, 3
    	mov ebx, 0
    	mov ecx, %1
    	mov edx, %2
    	int 80h
%endmacro

section .data
    	msg1 db 'Enter a number: '
    	msg1_len equ $-msg1
    	even_msg db 'The number is even', 10
    	even_msg_len equ $-even_msg
    	odd_msg db 'The number is odd', 10
    	odd_msg_len equ $-odd_msg
    	newline db 10
    	newline_len equ $-newline
section .bss
	num resb 3
section .text
	global _start
_start:
    	writesystem msg1, msg1_len
    	readsystem num, 2

    	mov al, [num]
    	sub al, '0'
    	mov ah, 0    
    	mov bl, 2    
    	div bl      

    	cmp ah, 0
    	je even_number
odd_number:
    	writesystem odd_msg, odd_msg_len
    	jmp exit
even_number:
    	writesystem even_msg, even_msg_len
exit:
    	mov eax, 1
    	xor ebx, ebx
    	int 80h
