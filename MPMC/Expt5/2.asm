%macro write 2
    mov eax, 4
    mov ebx, 1
    mov ecx, %1
    mov edx, %2
    int 0x80
%endmacro

section .data
    msg1 db 'Enter number 1: '
    msg1_len equ $ - msg1

    msg2 db 'Enter number 2: '
    msg2_len equ $ - msg2

    msg3 db 'Entered numbers are: '
    msg3_len equ $ - msg3
    
    comma db ','
    comma_len equ $-comma
    
    newline db 0xA
    newline_len equ $-newline

section .bss
    num1 resb 5
    num2 resb 5

section .text
    global _start

_start:
    write msg1, msg1_len

    mov eax, 3
    mov ebx, 0
    mov ecx, num1
    mov edx, 5
    int 0x80  

    write msg2, msg2_len

    mov eax, 3
    mov ebx, 0
    mov ecx, num2
    mov edx, 5
    int 0x80  

    mov ecx, num1
    mov edx, 5
find_newline1:
    cmp byte [ecx], 0xA
    je replace_newline1
    inc ecx
    dec edx
    jnz find_newline1
    jmp check_num2

replace_newline1:
    mov byte [ecx], 0

check_num2:
    mov ecx, num2
    mov edx, 5
find_newline2:
    cmp byte [ecx], 0xA
    je replace_newline2
    inc ecx
    dec edx
    jnz find_newline2
    jmp continue_output

replace_newline2:
    mov byte [ecx], 0

continue_output:
    write msg3, msg3_len
    write num1, 5
    write comma,comma_len
    write num2, 5
    write newline,newline_len

    mov eax, 1
    xor ebx, ebx
    int 0x80
