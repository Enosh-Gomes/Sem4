%macro write 2
	mov eax,4
	mov ebx,1
	mov ecx, %1
	mov edx, %2
	int 80h
%endmacro

section .data
	msg1 db 'Entered number is '
	msg1_len equ $-msg1
	msg2 db 'Enter a number: '
	msg2_len equ $-msg2
section .bss
	num resb 5
section .text
	global _start
_start:
	write msg2,msg2_len

	mov eax,3
	mov ebx,0
	mov ecx,num
	mov edx,5
	int 0x80
	
	write msg1,msg1_len	
	write num,5
	
	mov eax,1
	xor ebx,ebx
	int 0x80
