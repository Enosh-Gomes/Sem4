section .data
	string1 db "Enter the number of terms: ",
	string1_len equ $-string1
	string2 db "Fibonacci Series: ",0
	string2_len equ $-string2
	space db ' ',0
	newline db 10
	new_len equ $-newline
section .bss
	num resb 5
	a resb 5
	b resb 5
	c resb 5
	inter resb 5
	count resb 5
%macro write 2
	mov eax, 4
	mov ebx, 1
	mov ecx, %1
	mov edx, %2
	int 80h
%endmacro
%macro read 1
	mov eax, 3
	mov ebx, 2
	mov ecx, %1
	mov edx, 5
	int 80h
%endmacro
%macro addition 3
	mov eax, [%1]
	sub eax, '0'
	mov ebx, [%2]
	sub ebx, '0'
	add eax, ebx
	add eax, '0'
	mov [%3], eax
%endmacro
section .text
	global _start
_start:
	write string1, string1_len
	read num
	
	mov eax,[num]
	sub eax, '0'
	mov [num], eax
	mov al,[num]
	cmp al, 0
	jle exit
	
	write string2, string2_len
	mov eax, '0'
	mov [a], eax
	write a, 1	
        write space, 1
        
	mov al,[num]
	cmp al, 1
	je exit
	
	mov eax, '1'
	mov [b], eax
	write b, 1
        write space, 1
        
	mov al,[num]
	cmp al, 2
	je exit

	mov eax, 2
	mov [count], eax
loop:
	addition a, b, c
	write c, 1
        write space, 1

	mov eax, [b]
	mov [a], eax

	mov eax, [c]
	mov [b], eax

	inc byte[count]

	mov al, [count]
	mov bl, [num]
	cmp al, bl
	jl loop
exit:
	write newline,new_len
	mov eax, 1
	xor ebx, ebx
	int 80h
