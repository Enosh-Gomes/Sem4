%macro print 2
	push eax
	push ebx
	mov eax, 4
	mov ebx, 1
	mov ecx, %1
	mov edx, %2
	int 0x80
	pop ebx
	pop eax
%endmacro

%macro read 2
	mov eax, 3
	mov ebx, 0
	mov ecx, %1
	mov edx, %2
	int 0x80
%endmacro

section .data
	index dd 0
	
	prompt db "Enter 5 elements",10
	prompt_len equ $-prompt
	
	prompt_element db "Enter element", 0
	prompt_element_len equ $-prompt_element
	
	colon db ": ", 0
	colon_len equ $-colon
	
	prompt_target db "Enter the target number to search: ", 0
	prompt_target_len equ $-prompt_target
	
	msg_found db "Element found at index: ", 0
	msg_found_len equ $-msg_found
	
	msg_not_found db "Element not found", 0
	msg_not_found_len equ $-msg_not_found
	
	msg_iteration db "Iteration ", 0
	msg_iteration_len equ $-msg_iteration
	
	msg_left db ":   Low: ", 0
	msg_left_len equ $-msg_left
	
	msg_right db ",   High: ", 0
	msg_right_len equ $-msg_right
	
	msg_mid db ",   Mid: ", 0
	msg_mid_len equ $-msg_mid
	
	msg_value db ",   Value: ", 0
	msg_value_len equ $-msg_value
	
	newline db 10, 0
	newline_len equ $-newline

section .bss
	array resd 100
	size resd 1
	target resd 1
	buffer resb 16
	sign resb 1
	number_is_negative resb 1
	iteration_count resd 1
	left resd 1
	right resd 1

section .text
	global _start
_start:
	print prompt,prompt_len
	mov dword [size], 5
	mov ecx, [size]
	mov edi, array

.input_loop:
	push ecx
	push edi
	
	print prompt_element, prompt_element_len
	print colon, colon_len
	call read_signed
	
	pop edi
	mov [edi], eax
	add edi, 4
	
	pop ecx
	loop .input_loop
	
	call bubble_sort
	
	print newline,newline_len
	print prompt_target, prompt_target_len
	call read_signed
	mov [target], eax
	
	mov dword [left], 0
	mov eax, [size]
	dec eax
	mov [right], eax
	mov dword [iteration_count], 1
	
	print newline,newline_len

.search_loop:
	mov eax, [left]
	cmp eax, [right]
	jg .not_found
	
	mov eax, [left]
	mov ebx, [right]
	add eax, ebx
	shr eax, 1        ; divide by 2
	mov [index], eax
	
	print msg_iteration, msg_iteration_len
	mov eax, [iteration_count]
	call print_int
	
	print msg_left, msg_left_len
	mov eax, [left]
	call print_int
	
	print msg_right, msg_right_len
	mov eax, [right]
	call print_int

	print msg_mid, msg_mid_len
	mov eax, [index]
	call print_int
	
	print msg_value, msg_value_len
	mov edx, [index]
	mov eax, [array + edx * 4]
	call print_int
	print newline, newline_len	
	
	mov edx, [index]
	mov eax, [array + edx * 4]
	cmp [target], eax
	
	je .found
	jl .search_left
	jg .search_right

.search_left:
 	mov eax, [index]
	dec eax
	mov [right], eax
	inc dword [iteration_count]
	jmp .search_loop

.search_right:
	mov eax, [index]
	inc eax
	mov [left], eax
	inc dword [iteration_count]
	jmp .search_loop

.found:
	print newline, newline_len
	print msg_found, msg_found_len
	mov eax, [index]
	call print_int
	print newline, newline_len
	jmp .exit

.not_found:
	print msg_not_found, msg_not_found_len
	print newline, newline_len

.exit:
	mov eax, 1
	xor ebx, ebx
	int 0x80

read_signed:
	push ebp
	mov ebp, esp
	mov byte [number_is_negative], 0
	read buffer, 16

	xor eax, eax
	mov ecx, buffer
	movzx edx, byte [ecx]

	cmp dl, '-'
	jne .process_digits
	mov byte [number_is_negative], 1
	inc ecx

.process_digits:
	xor eax, eax
.read_loop:
	movzx edx, byte [ecx]
	cmp dl, 0xA
	je .apply_sign
	cmp dl, 0
	je .apply_sign
	cmp dl, '0'
	jb .apply_sign
	cmp dl, '9'
	ja .apply_sign
	sub dl, '0'
	imul eax, 10
	add eax, edx
	inc ecx
	jmp .read_loop

.apply_sign:
	cmp byte [number_is_negative], 0
	je .done
	neg eax

.done:
	mov esp, ebp
	pop ebp
	ret

print_int:
    push eax
    push ebx
    push ecx
    push edx
    push esi
    push edi

    mov edi, buffer + 15
    mov byte [edi], 0
    mov ecx, 10
    xor edx, edx

    cmp eax, 0
    jl .negative
    jmp .convert

.negative:
    neg eax
    mov bl, '-'
    mov byte [sign], bl
    jmp .convert

.convert:
    xor edx, edx
    div ecx
    add dl, '0'
    dec edi
    mov [edi], dl
    test eax, eax
    jnz .convert

    cmp byte [sign], '-'
    jne .print
    dec edi
    mov byte [edi], '-'

.print:
    mov eax, 4
    mov ebx, 1
    mov ecx, edi
    mov edx, buffer + 15
    sub edx, edi
    int 0x80

    mov bl,'0'
    mov [sign],bl
    pop edi
    pop esi
    pop edx
    pop ecx
    pop ebx
    pop eax
    ret

bubble_sort:
	push eax
	push ebx
	push ecx
	push edx
	push esi
	push edi

	mov ecx, [size]
	dec ecx
	test ecx, ecx
	jle .done
	
.outer_loop:
	mov esi, 0
	xor edx, edx        ; Flag to track if any swaps were made in this pass

.inner_loop:
	mov eax, [array + esi * 4]
	mov ebx, [array + esi * 4 + 4]
	cmp eax, ebx
	jle .no_swap

	;; swap [esi] and [esi+1]
	mov [array + esi * 4], ebx
	mov [array + esi * 4 + 4], eax
	mov edx, 1          ; Set swap flag

.no_swap:
	inc esi
	cmp esi, ecx        ; Compare with total passes needed (size-1)
	jl .inner_loop

	test edx, edx       ; Check if any swaps were made
	jz .done            ; If no swaps, array is sorted

	loop .outer_loop

.done:	
	pop edi
	pop esi
	pop edx
	pop ecx
	pop ebx
	pop eax
	ret
