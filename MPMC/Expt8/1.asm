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
    
    output_msg db 'Array elements are:', 0xA, 0
    output_len equ $ - output_msg
    
    error_msg db 'Invalid input, try again', 0xA, 0
    error_len equ $ - error_msg
    
    space db ' ', 0
    newline db 0xA, 0
    minus db '-', 0
    
    ARRAY_SIZE equ 5

section .bss
    array resw ARRAY_SIZE
    input_buf resb 16
    
section .text
    global _start
_start:
    xor esi, esi
    jmp input_loop
    
input_loop:
    cmp esi, ARRAY_SIZE
    jge display_array
    
    write input_msg,input_len
    
    call read_num_signed
    
    cmp edx, -1
    je invalid_input
    
    mov [array + esi*2], ax
    inc esi
    jmp input_loop
    
invalid_input:
    write error_msg,error_len
    jmp input_loop
    
display_array:
    write output_msg,output_len
    
    xor esi, esi
    
output_loop:
    cmp esi, ARRAY_SIZE
    jge exit_program
    
    movsx eax, word [array + esi*2]
    call print_num_signed
    
    write space,1
    
    inc esi
    jmp output_loop
    
exit_program:
    write newline,1
    
    mov eax, 1
    xor ebx, ebx
    int 0x80

read_num_signed:
    push ebp
    mov ebp, esp
    push edi
    
    read input_buf,16
    
    cmp eax, 1
    jl read_signed_error
    
    xor eax, eax
    xor ebx, ebx
    mov ecx, input_buf
    xor edi, edi
    
    movzx edx, byte [ecx]
    cmp dl, '-'
    jne check_digit
    
    mov edi, 1
    inc ecx
    
check_digit:
    movzx edx, byte [ecx]
    
    cmp dl, 0xA
    je done_convert_signed
    cmp dl, 0
    je done_convert_signed
    
    cmp dl, '0'
    jl read_signed_error
    cmp dl, '9'
    jg read_signed_error
    
    sub dl, '0'
    imul eax, 10
    add eax, edx
    
    cmp eax, 32768
    jg read_signed_error
    
    inc ecx
    jmp check_digit
    
read_signed_error:
    mov eax, 0
    mov edx, -1
    jmp read_signed_exit
    
done_convert_signed:
    test edi, edi
    jz positive_number
    
    neg eax
    
positive_number:
    mov edx, 0
    
read_signed_exit:
    pop edi
    mov esp, ebp
    pop ebp
    ret

print_num_signed:
    push ebx
    push ecx
    push edx
    push esi
    
    test eax, eax
    jns positive_print
    
    push eax
    
    write minus,1
    
    pop eax
    neg eax
    
positive_print:
    mov ecx, input_buf
    add ecx, 15
    mov byte [ecx], 0
    
    test eax, eax
    jnz not_zero
    
    dec ecx
    mov byte [ecx], '0'
    jmp print_digits
    
not_zero:
    mov ebx, 10
    
convert_to_string:
    dec ecx
    xor edx, edx
    div ebx
    add dl, '0'
    mov [ecx], dl
    test eax, eax
    jnz convert_to_string
    
print_digits:
    mov esi, input_buf
    add esi, 15
    sub esi, ecx
    
    ;mov eax, 4
    ;mov ebx, 1
    ;mov edx, esi
    ;int 0x80
    write ecx,esi
    
    pop esi
    pop edx
    pop ecx
    pop ebx
    ret
