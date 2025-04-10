section .data
	msg1 db 'Enter number 1: '
	msg1Len equ $ - msg1
	msg2 db 'Enter number 2: '
	msg2Len equ $ - msg2
	msg3 db 'Enter number 3: '
	msg3Len equ $ - msg3
	msg4 db 'All 3 numbers are equal to '
	msg4Len equ $-msg4
	msg db 'Largest number is '
	msgLen equ $ - msg
section .bss
	num1 resb 5
	num2 resb 5
	num3 resb 5
section .text
	global _start
_start:
	mov eax,4
	mov ebx,1
	mov ecx,msg1
	mov edx,msg1Len
	int 80h
	
	mov eax,3
	mov ebx,0
	mov ecx,num1
	mov edx,5
	int 80h
	
	mov eax,4
	mov ebx,1
	mov ecx,msg2
	mov edx,msg2Len
	int 80h
	
	mov eax,3
	mov ebx,0
	mov ecx,num2
	mov edx,5
	int 80h
	
	mov eax,4
	mov ebx,1
	mov ecx,msg3
	mov edx,msg3Len
	int 80h
	
	mov eax,3
	mov ebx,0
	mov ecx,num3
	mov edx,5
	int 80h
	
	mov eax,[num1]
	sub eax,'0'
	mov ebx,[num2]
	sub ebx,'0'
	
	cmp eax,ebx
	jg large_num1
	jl large_num2
	
	mov eax,[num3]
	sub eax,'0'
	cmp eax,ebx
	je equal
	
large_num1:
	mov eax,[num1]
	sub eax,'0'
	mov ebx,[num3]
	sub ebx,'0'
	
	cmp eax,ebx
	jg num1_large
	jmp num3_large

large_num2:
	mov eax,[num2]
	sub eax,'0'
	mov ebx,[num3]
	sub ebx,'0'
	
	cmp eax,ebx
	jg num2_large
	jmp num3_large

num1_large:
	mov eax,4
	mov ebx,1
	mov ecx,msg
	mov edx,msgLen
	int 80h
	
	mov eax,4
	mov ebx,1
	mov ecx,num1
	mov edx,5
	int 80h
	
	jmp end_program

num2_large:
	mov eax,4
	mov ebx,1
	mov ecx,msg
	mov edx,msgLen
	int 80h
	
	mov eax,4
	mov ebx,1
	mov ecx,num2
	mov edx,5
	int 80h
	
	jmp end_program
	
num3_large:
	mov eax,4
	mov ebx,1
	mov ecx,msg
	mov edx,msgLen
	int 80h
	
	mov eax,4
	mov ebx,1
	mov ecx,num3
	mov edx,5
	int 80h
	
	jmp end_program

equal:
	mov eax,4
	mov ebx,1
	mov ecx,msg4
	mov edx,msg4Len
	int 80h
	
	mov eax,4
	mov ebx,1
	mov ecx,num3
	mov edx,5
	int 80h

end_program:	
	mov eax,1
	xor ebx,ebx
	int 80h
