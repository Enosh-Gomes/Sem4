section .data
	msg1 db 'Enter a number: '
	msg1_len equ $-msg1
    
	msg_greater db 'Number is greater than 5', 10
	msg_greater_len equ $-msg_greater
    
	msg_less db 'Number is less than 5', 10
	msg_less_len equ $-msg_less
    
	msg_equal db 'Number is equal to 5', 10
	msg_equal_len equ $-msg_equal
section .bss
	num resb 2
section .text
	global _start
_start:
   	mov eax, 4
	mov ebx, 1
	mov ecx, msg1
	mov edx, msg1_len
	int 80h
	
	mov eax, 3
	mov ebx, 0
	mov ecx, num
	mov edx, 2
	int 80h
    
    	mov al, [num]
    	sub al, '0'
    
    	cmp al, 5    	
  	jg greater
 	jl less
 	;je equal
 	
 	mov eax, 4
	mov ebx, 1
	mov ecx, msg_equal
	mov edx, msg_equal_len
	int 80h
    	jmp exit

greater:
    	mov eax, 4
	mov ebx, 1
	mov ecx, msg_greater
	mov edx, msg_greater_len
	int 80h
    	jmp exit

less:
    	mov eax, 4
	mov ebx, 1
	mov ecx, msg_less
	mov edx, msg_less_len
	int 80h
    	jmp exit

;equal:
;    	mov eax, 4
;	mov ebx, 1
;	mov ecx, msg_equal
;	mov edx, msg_equal_len
;	int 80h
;    	jmp exit

exit:
   	mov eax, 1
	mov ebx, 0
    	int 80h
