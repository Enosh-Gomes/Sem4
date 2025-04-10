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
    prompt db "Enter 5 elements", 10
    prompt_len equ $-prompt

    prompt_element db "Enter element: ", 0
    prompt_element_len equ $-prompt_element

    prompt_target db "Enter the number to search: ", 0
    prompt_target_len equ $-prompt_target

    msg_found db "Element found at index: ", 0
    msg_found_len equ $-msg_found

    msg_not_found db "Element not found", 0
    msg_not_found_len equ $-msg_not_found

    msg_iteration db "Iteration ", 0
    msg_iteration_len equ $-msg_iteration

    msg_checking db ":    Index: ", 0
    msg_checking_len equ $-msg_checking

    msg_value db "     Value: ", 0
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
    current resd 1

section .text
    global _start
_start:
    print prompt, prompt_len
    mov dword [size], 5
    xor esi, esi

input_loop:
    cmp esi, [size]
    jge input_done
    print prompt_element, prompt_element_len
    call read_signed
    mov [array + esi * 4], eax
    inc esi
    jmp input_loop

input_done:
    print newline, newline_len
    print prompt_target, prompt_target_len
    call read_signed
    mov [target], eax
    print newline, newline_len
    xor esi, esi

search_loop:
    cmp esi, [size]
    jge not_found
    print msg_iteration, msg_iteration_len
    mov eax, esi
    inc eax
    call print_int

    print msg_checking, msg_checking_len
    mov eax, esi
    call print_int

    print msg_value, msg_value_len
    mov eax, [array + esi * 4]
    mov [current], eax
    call print_int
    print newline, newline_len

    mov eax, [current]
    cmp eax, [target]
    je found
    inc esi
    jmp search_loop

found:
    print newline, newline_len
    print msg_found, msg_found_len
    mov eax, esi
    call print_int
    print newline, newline_len
    jmp exit_program

not_found:
    print msg_not_found, msg_not_found_len
    print newline, newline_len

exit_program:
    mov eax, 1
    xor ebx, ebx
    int 0x80

; ---------------------------------------
; Read signed integer like in binary search
; ---------------------------------------
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

; ---------------------------------------
; Print signed integer (used in binary search)
; ---------------------------------------
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

    mov bl, '0'
    mov [sign], bl

    pop edi
    pop esi
    pop edx
    pop ecx
    pop ebx
    pop eax
    ret

