section .data
    	msg1 db 'Enter a number: '
    	msg1_len equ $-msg1
    	msg2 db 'Next 4 numbers are: '
    	msg2_len equ $-msg2
    	space db ' '
    	space_len equ $-space
    	newline db 10
    	newline_len equ $-newline
section .bss
    	num resb 1
section .text
    	global _start
_start:
    	mov eax, 4
    	mov ebx, 1
    	mov ecx, msg1
    	mov edx, msg1_len
    	int 80h

    	mov eax, 3
    	mov ebx, 2
    	mov ecx, num
    	mov edx, 1
    	int 80h

    	mov eax, 4
    	mov ebx, 1
    	mov ecx, msg2
    	mov edx, msg2_len
    	int 80h

    	mov eax, [num]
    	sub eax, '0'
   
    	mov edx, eax
    	mov ecx, 4

print_loop:
    	inc edx
    	mov eax, edx
    	add eax, '0'
    	mov [num], eax

    	push edx
    	push ecx

    	mov eax, 4
    	mov ebx, 1
    	mov ecx, num
    	mov edx, 1
    	int 80h

    	mov eax, 4
    	mov ebx, 1
    	mov ecx, space
    	mov edx, space_len
    	int 80h

    	pop ecx
    	pop edx

    	dec ecx
    	jnz print_loop

    	mov eax, 4
    	mov ebx, 1
    	mov ecx, newline
    	mov edx, newline_len
    	int 80h

    	mov eax, 1
    	xor ebx, ebx
    	int 80h
