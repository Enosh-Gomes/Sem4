section .data
	prompt1 db 'Enter first string: ', 0
	prompt1_len equ $-prompt1
    
    	prompt2 db 'Enter second string: ', 0
    	prompt2_len equ $-prompt2
    
    	msg_equal db 'Strings are equal', 10
    	msg_equal_len equ $-msg_equal
    
    	first_larger db 'First string is larger', 10
    	first_larger_len equ $-first_larger
    
    	second_larger db 'Second string is larger', 10
    	second_larger_len equ $-second_larger
    
    	newline db 10
    	newline_len equ $-newline
section .bss
    	string1 resb 100
    	string2 resb 100
    	str1_len resb 1
    	str2_len resb 1

section .text
    	global _start
_start:
    	mov eax, 4
    	mov ebx, 1
    	mov ecx, prompt1
    	mov edx, prompt1_len
    	int 80h
    	
    	mov eax, 3
    	mov ebx, 0
    	mov ecx, string1
    	mov edx, 100
    	int 80h
    	
    	mov [str1_len], al
    
    	mov eax, 4
    	mov ebx, 1
    	mov ecx, prompt2
    	mov edx, prompt2_len
    	int 80h
    	
    	mov eax, 3
    	mov ebx, 0
    	mov ecx, string2
    	mov edx, 100
    	int 80h
    	
    	mov [str2_len], al

    	mov esi, string1         
    	mov edi, string2         
    	mov ecx, 100            
    	cld

compare_loop:
    	cmpsb
    	jne check_larger        
    	cmp byte [esi-1], 10    
    	je strings_equal        
    	loop compare_loop

check_larger:
    	mov al, [esi-1]         
    	mov bl, [edi-1]         
    	cmp al, bl
    	ja first_is_larger
    	jmp second_is_larger    

strings_equal:
    	mov eax, 4
    	mov ebx, 1
    	mov ecx, msg_equal
    	mov edx, msg_equal_len
    	int 80h
    	
    	jmp exit

first_is_larger:
    	mov eax, 4
    	mov ebx, 1
    	mov ecx, first_larger
    	mov edx, first_larger_len
    	int 80h
    	
    	jmp exit

second_is_larger:
    	mov eax, 4
    	mov ebx, 1
    	mov ecx, second_larger
    	mov edx, second_larger_len
    	int 80h
    	
    	jmp exit

exit:
    	mov eax, 1
    	xor ebx, ebx
    	int 80h
