section .data
	prompt db "Enter the number of terms: ",
	prompt_len equ $-prompt
	msg db "Fibonacci Series: ",0
	msg_len equ $-msg
	space db ' ',0
	newline db 10
	new_len equ $-newline
	
section .bss
	n resb 5
	num1 resb 5
	num2 resb 5
	result resb 5
	count resb 5

section .text
	global _start	
		
write_prompt:
    	mov eax, 4
    	mov ebx, 1
    	mov ecx, prompt
    	mov edx, prompt_len
    	int 80h
    	ret

read_n:
    	mov eax, 3
    	mov ebx, 0
    	mov ecx, n
    	mov edx, 2
    	int 80h
    	ret

write_msg:
    	mov eax, 4
    	mov ebx, 1
    	mov ecx, msg
    	mov edx, msg_len
    	int 80h
    	ret

write_num1:
    	mov eax, 4
    	mov ebx, 1
    	mov ecx, num1
    	mov edx, 1
    	int 80h
    	ret
    	
write_num2:
    	mov eax, 4
    	mov ebx, 1
    	mov ecx, num2
    	mov edx, 1
    	int 80h
    	ret
   
write_result:
    	mov eax, 4
    	mov ebx, 1
    	mov ecx, result
    	mov edx, 1
    	int 80h
    	ret
    	
write_space:
    	mov eax, 4
    	mov ebx, 1
    	mov ecx, space
    	mov edx, 1
    	int 80h
    	ret

write_newline:
    	mov eax, 4
    	mov ebx, 1
    	mov ecx, newline
    	mov edx, 1
    	int 80h
    	ret

add_nums:
    	mov eax, [num1]
    	sub al, '0'
    	mov ebx, [num2]
    	sub bl, '0'
    	add eax, ebx
    	add eax, '0'
    	mov [result], al
    	ret

_start:
	call write_prompt
	call read_n
	
	mov eax,[n]
	sub eax, '0'
	mov [n], eax
	mov al,[n]
	cmp al, 0
	jle exit
	
	call write_msg
	mov eax, '0'
	mov [num1], eax
	call write_num1	
        call write_space
        
	mov al,[n]
	cmp al, 1
	je exit
	
	mov eax, '1'
	mov [num2], eax
	call write_num2
        call write_space
        
	mov al,[n]
	cmp al, 2
	je exit

	mov eax, 2
	mov [count], eax
loop:
	call add_nums
	call write_result
        call write_space

	mov eax, [num2]
	mov [num1], eax
	mov eax, [result]
	mov [num2], eax

	inc byte[count]

	mov al, [count]
	mov bl, [n]
	cmp al, bl
	jl loop
exit:
	call write_newline
	mov eax, 1
	xor ebx, ebx
	int 80h
