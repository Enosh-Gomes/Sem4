section .data
	prompt db 'Enter the number: ',0
    	prompt_len equ $ - prompt
    	msg db 'Factorial: ',0
    	msg_len equ $ - msg
    	error db 'Factorial of negative number cannot be computed!',10
    	error_len equ $-error
    	newline db 10,0
    	newline_len equ $-newline

section .bss
	n resb 2
	result resb 2

section .text
	global _start
_start:
	call write_prompt
	call read_n
	call write_msg

    	mov ecx, [n]
    	sub ecx, '0'
    	cmp ecx,0
    	jl invalid

    	mov eax, 1
    	call factorial
    	call write_result
        call write_newline
        jmp exit
exit:	
	mov eax,1
	xor ebx,ebx
	int 80h
	
invalid:
	mov eax,4
	mov ebx,1
	mov ecx,error
	mov edx,error_len
	int 80h
	jmp exit

write_prompt:
	mov eax,4
	mov ebx,1
	mov ecx,prompt
	mov edx,prompt_len
	int 80h
	ret

read_n:
	mov eax,3
	mov ebx,0
	mov ecx,n
	mov edx,1
	int 80h
	ret

write_msg:
	mov eax,4
	mov ebx,1
	mov ecx,msg
	mov edx,msg_len
	int 80h
	ret

write_newline:
	mov eax,4
	mov ebx,1
	mov ecx,newline
	mov edx,newline_len
	int 80h
	ret

write_result:
	mov eax,4
	mov ebx,1
	mov ecx,result
	mov edx,2
	int 80h
	ret

factorial:
    	cmp ecx, 1
    	jle end_factorial
    	
    	imul eax, ecx
    	dec ecx
    	call factorial
    	ret
    	
end_factorial:
	add eax,'0'
    	mov [result], eax
    	ret
