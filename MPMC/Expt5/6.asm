%macro write 2
    	mov eax, 4
    	mov ebx, 1
	mov ecx, %1
    	mov edx, %2
    	int 80h
%endmacro

%macro read 2
    	mov eax, 3
    	mov ebx, 0
	mov ecx, %1
    	mov edx, %2
    	int 80h
%endmacro

section .data
    	;msg db "Enosh", 10
    	;msg_len equ $ - msg
    	prompt db "Enter your name: ",0
    	prompt_len equ $-prompt
section .bss
	name resb 10
section .text
	global _start
_start:
	write prompt,prompt_len
	read name,10
	
    	mov esi, 7
loop:
    	push esi
    	write name, 10
    	pop esi
    	dec esi
    	cmp esi, 0
    	jne loop

	mov eax, 1
	mov ebx,0
	int 80h
