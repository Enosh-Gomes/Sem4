%macro write 2
    mov eax, 4
    mov ebx, 1
    mov ecx, %1
    mov edx, %2
    int 80h
%endmacro

%macro read 2
    mov eax, 3
    mov ebx, 0
    mov ecx, %1
    mov edx, %2
    int 80h
%endmacro

section .data
    input_msg db 'Enter element: ', 0
    input_len equ $ - input_msg
    pos_msg db 'Number of positive numbers: ', 0
    pos_len equ $ - pos_msg
    neg_msg db 'Number of negative numbers: ', 0
    neg_len equ $ - neg_msg
    error_input db 'Error: Invalid input, try again', 0xA, 0
    error_input_len equ $ - error_input
    error_overflow db 'Error: Number too large or too small', 0xA, 0
    error_overflow_len equ $ - error_overflow
    newline db 0xA, 0
  
section .bss
    array resw 5
    pos_count resw 1
    neg_count resw 1
    input_buf resb 16
    number_is_negative resb 1

section .text
    global _start

_start:
    mov word [pos_count], 0
    mov word [neg_count], 0
    xor esi, esi

input_loop:
    cmp si, 5
    jge count_display
    
    write input_msg, input_len
    call read_signed_num
    
    cmp edx, -1
    je invalid_element_input
    
    mov [array + esi*2], ax
    test ax, ax
    jz skip_counting
    js increment_negative
    
    inc word [pos_count]
    jmp skip_counting

increment_negative:
    inc word [neg_count]

skip_counting:
    inc esi
    jmp input_loop

invalid_element_input:
    write error_input, error_input_len
    jmp input_loop

count_display:
    write pos_msg, pos_len
    movzx eax, word [pos_count]
    call print_num
    write newline, 1
    
    write neg_msg, neg_len
    movzx eax, word [neg_count]
    call print_num
    write newline, 1
    
    mov eax, 1
    xor ebx, ebx
    int 0x80

read_signed_num:
    push ebp
    mov ebp, esp
    mov byte [number_is_negative], 0
    
    read input_buf, 16
    cmp eax, 1
    jl read_signed_error
    
    xor eax, eax
    mov ecx, input_buf
    movzx edx, byte [ecx]
    cmp dl, 0xA
    je read_signed_error
    cmp dl, 0
    je read_signed_error
    
    cmp byte [ecx], '-'
    jne process_digits_signed
    
    mov byte [number_is_negative], 1
    inc ecx
    
    movzx edx, byte [ecx]
    cmp dl, 0xA
    je read_signed_error
    cmp dl, 0
    je read_signed_error

process_digits_signed:
    movzx edx, byte [ecx]
    cmp dl, 0xA
    je finish_signed_number
    cmp dl, 0
    je finish_signed_number
    
    cmp dl, '0'
    jl read_signed_error
    cmp dl, '9'
    jg read_signed_error
    
    sub dl, '0'
    cmp eax, 3276
    jg check_signed_overflow
    
    imul eax, 10
    jo read_signed_error
    add eax, edx
    jo read_signed_error
    
    inc ecx
    jmp process_digits_signed

check_signed_overflow:
    cmp eax, 3276
    jne read_signed_error
    cmp dl, 7
    jg read_signed_error
    
    imul eax, 10
    add eax, edx
    
    inc ecx
    jmp process_digits_signed

finish_signed_number:
    cmp byte [number_is_negative], 0
    je signed_number_done
    
    cmp eax, 32768
    jg read_signed_error
    
    neg eax

signed_number_done:
    xor edx, edx
    jmp read_signed_exit

read_signed_error:
    write error_overflow, error_overflow_len
    xor eax, eax
    mov edx, -1

read_signed_exit:
    mov esp, ebp
    pop ebp
    ret

print_num:
    push ebx
    push ecx
    push edx
    push esi
    
    test eax, eax
    jnz non_zero_print
    
    mov ecx, input_buf
    mov byte [ecx], '0'
    write input_buf, 1
    jmp print_exit

non_zero_print:
    mov ecx, input_buf
    add ecx, 15
    mov byte [ecx], 0
    
    mov ebx, 10

print_convert:
    dec ecx
    xor edx, edx
    div ebx
    add dl, '0'
    mov [ecx], dl
    test eax, eax
    jnz print_convert
    
    mov esi, input_buf
    add esi, 15
    sub esi, ecx
    write ecx, esi

print_exit:
    pop esi
    pop edx
    pop ecx
    pop ebx
    ret

