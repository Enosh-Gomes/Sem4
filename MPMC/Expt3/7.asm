section .data
	msg db 'Multiples of 3 (0-9): ', 0
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
	mov ecx, msg
	mov edx, len
	int 0x80
	
	mov al, '0'
	mov [num], al
	
print_loop:
	mov al, [num]
	sub al, '0'
	xor ah, ah
	
	mov bl, 3
	div bl
	cmp ah, 0
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
	add al, 1
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
