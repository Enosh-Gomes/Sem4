%macro write 2
	mov eax,4
	mov ebx,1
	mov ecx, %1
	mov edx, %2
	int 80h
%endmacro
%macro read 2
	mov eax,3
	mov ebx,0
	mov ecx, %1
	mov edx, %2
	int 80h
%endmacro
%macro addition 2
	mov eax,[%1]
	sub eax,'0'
	mov ebx,[%2]
	sub ebx,'0'
	add eax,ebx
	add eax,'0'
	mov [result],eax
%endmacro
%macro subtraction 2
	mov eax,[%1]
	sub eax,'0'
	mov ebx,[%2]
	sub ebx,'0'
	sub eax,ebx
	add eax,'0'
	mov [result],eax
%endmacro
%macro multiplication 2
	mov eax,[%1]
	sub eax,'0'
	mov ebx,[%2]
	sub ebx,'0'
	mul ebx
	add eax,'0'
	mov [result],eax
%endmacro
%macro division 2	
	mov al, [%1]
	sub al, '0'
	mov bl, [%2]
	sub bl, '0'	
	cmp bl,0
	je divide_error	
	div bl
	add al, '0'	
	mov [result], al
	add ah, '0'
	mov [remainder], ah
%endmacro
section .data
	msg1 db 'Enter number 1: ',0
	msg1Len equ $-msg1	
	msg2 db 'Enter number 2: ',0
	msg2Len equ $-msg2	
	addn db 'Sum = ',0
	addnLen equ $-addn	
	subt db 'Difference = ',0
	subtLen equ $-subt	
	mult db 'Product = ',0
	multLen equ $-mult	
	qnt db 'Quotient = ',0
	qntLen equ $-qnt	
	rmd db 'Remainder = ',0
	rmdLen equ $-rmd	
	err db 'Error: Division by 0',0
	errLen equ $-err	
	newline db 0xA
	newlineLen equ $-newline	
section .bss
	num1 resb 4
	num2 resb 4
	result resb 4
	remainder resb 4	
section .text
	global _start
_start:
	write msg1, msg1Len
	read num1, 4	
	write msg2, msg2Len
	read num2, 4	
find_newline1:
    	cmp byte [ecx], 0xA
    	je replace_newline1
    	inc ecx
    	dec edx
    	jnz find_newline1
replace_newline1:
    	mov byte [ecx], 0
find_newline2:
    	cmp byte [ecx], 0xA
    	je replace_newline2
    	inc ecx
    	dec edx
    	jnz find_newline2
replace_newline2:
    	mov byte [ecx], 0
Add:
	addition num1,num2
	write addn,addnLen
	write result,4
subtract:
	subtraction num1,num2	
	write subt,subtLen
	write result,4
multiply:
	multiplication num1,num2
	write mult,multLen
	write result,4
	write newline, newlineLen
divide:
	division num1,num2
	write qnt,qntLen
	write result,4
	write newline, newlineLen	
	write rmd,rmdLen
	write remainder,4
	write newline, newlineLen	
	jmp exit
divide_error:
	write err,errLen
	write newline, newlineLen
exit:
	mov eax,1
	xor ebx,ebx
	int 80h
