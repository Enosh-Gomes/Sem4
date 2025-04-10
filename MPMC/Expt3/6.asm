section .data
	msg1 db 'Press 0: ', 0
	l1 equ $-msg1
	msg db 'Odd numbers (1-9): ', 0
	len equ $-msg
	newline db 0xA, 0
	space db ' ', 0
section .bss
	num resb 1
	result resb 1
section .text
	global _start
_start:
	mov eax, 4
	mov ebx, 1
	mov ecx, msg1
	mov edx, l1
	int 0x80
	
	mov eax, 3
	mov ebx, 2
	mov ecx, num
	mov edx, 1
	int 0x80
	
	mov eax, 4
	mov ebx, 1
	mov ecx, msg
	mov edx, len
	int 0x80
	
	mov al, '1'
	mov [num], al
	
print_loop:
	mov al, [num]
	sub al, '0'
	mov bl, 2
	div bl
	cmp ah, 1
	jne skip_print
	
	mov eax, 4
	mov ebx, 1
	mov ecx, num
	mov edx, 1
	int 0x80
	
	mov eax, 4
	mov ebx, 1
	mov ecx, space
	mov edx, 1
	int 0x80
	
skip_print:
	mov al, [num]
	add al, 2
	mov [num], al
	cmp al, '9'
	jg end_program
	jmp print_loop
	
end_program:
	mov eax, 4
	mov ebx, 1
	mov ecx, newline
	mov edx, 1
	int 0x80

	mov eax, 1
	xor ebx, ebx
	int 0x80
