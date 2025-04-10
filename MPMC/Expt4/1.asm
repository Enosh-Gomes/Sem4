section .data
	msg1 db 'Enter number 1: '
	msg1Len equ $ - msg1
	msg2 db 'Enter number 2: '
	msg2Len equ $ - msg2
	msg db 'Largest number is '
	msgLen equ $ - msg
	msge db 'Both number are equal to '
	msgeLen equ $-msge
section .bss
	num1 resb 5
	num2 resb 5
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
		
	mov eax,[num1]
	sub eax,'0'
	mov ebx,[num2]
	sub ebx,'0'
	
	cmp eax,ebx
	jg large_num1
	jl large_num2
	
	mov eax,4
	mov ebx,1
	mov ecx,msge
	mov edx,msgeLen
	int 80h
	
	mov eax,4
	mov ebx,1
	mov ecx,num2
	mov edx,5
	int 80h
	
	jmp end_program
	
large_num1:
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
	
large_num2:
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

end_program:	
	mov eax,1
	xor ebx,ebx
	int 80h
