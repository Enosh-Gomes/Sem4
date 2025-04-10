section .data
	msg db ' ',10
	len equ $-msg
	msg1 db 'Number 1: '
	msg1Len equ $-msg1
	msg2 db 'Number 2: '
	msg2Len equ $-msg2
	msg3 db 'Sum: '
	msg3Len equ $-msg3
	msg4 db 'Difference: '
	msg4Len equ $-msg4
	msg5 db 'Product: '
	msg5Len equ $-msg5
	msg6 db 'Quotient: '
	msg6Len equ $-msg6
	msg7 db 'Remainder: '
	msg7Len equ $-msg7
section .bss
	num1 RESB 5
	num2 RESB 5
	sum RESB 5
	diff RESB 5
	prod RESB 5
	quot RESB 5
	rem RESB 5
section .text
	global _start
_start:
	mov eax,4
	mov ebx,1
	mov ecx,msg1
	mov edx,msg1Len
	int 80h
	
	mov eax,3
	mov ebx,2
	mov ecx,num1
	mov edx,10
	int 80h
	
	mov eax,4
	mov ebx,1
	mov ecx,msg2
	mov edx,msg2Len
	int 80h
	
	mov eax,3
	mov ebx,2
	mov ecx,num2
	mov edx,5
	int 80h
	
	mov eax, [num1]
	sub eax, '0'
	mov ebx, [num2]
	sub ebx, '0'
	add eax, ebx
	add eax, '0'
	mov [sum], eax
	
	mov eax,4
	mov ebx,1
	mov ecx,msg3
	mov edx,msg3Len
	int 80h
	
	mov eax,4
	mov ebx,1
	mov ecx,sum
	mov edx,1
	int 80h
	
	mov eax,4
	mov ebx,1
	mov ecx,msg
	mov edx,len
	int 80h
	
	mov eax, [num1]
	sub eax, '0'
	mov ebx, [num2]
	sub ebx, '0'
	sub eax, ebx
	add eax, '0'
	mov [diff], eax

	mov eax,4
	mov ebx,1
	mov ecx,msg4
	mov edx,msg4Len
	int 80h
	
	mov eax,4
	mov ebx,1
	mov ecx,diff
	mov edx,1
	int 80h
	
	mov eax,4
	mov ebx,1
	mov ecx,msg
	mov edx,len
	int 80h
	
	mov eax, [num1]
	sub eax, '0'
	mov ebx, [num2]
	sub ebx, '0'
	mul ebx
	add eax, '0'
	mov [prod], eax
	
	mov eax, 4
	mov ebx, 1
	mov ecx,msg5
	mov edx,msg5Len
	int 80h
	
	mov eax, 4
	mov ebx, 1
	mov ecx, prod
	mov edx, 1
	int 80h
	
	mov eax,4
	mov ebx,1
	mov ecx,msg
	mov edx,len
	int 80h
	
	mov al, [num1]
	sub al, '0'
	mov bl, [num2]
	sub bl, '0'
	div bl
	add al, '0'
	
	mov [quot], al
	add ah, '0'
	mov [rem], ah
	
	mov eax, 4
	mov ebx, 1
	mov ecx,msg6
	mov edx,msg6Len
	int 80h
	
	mov eax, 4
	mov ebx, 1
	mov ecx, quot
	mov edx, 1
	int 80h
	
	mov eax,4
	mov ebx,1
	mov ecx,msg
	mov edx,len
	int 80h
	
	mov eax, 4
	mov ebx, 1
	mov ecx,msg7
	mov edx,msg7Len
	int 80h
	
	mov eax, 4
	mov ebx, 1
	mov ecx, rem
	mov edx, 1
	int 80h
	
	mov eax,4
	mov ebx,1
	mov ecx,msg
	mov edx,len
	int 80h
	
	mov eax, 1
	mov ebx, 0
	int 80h
