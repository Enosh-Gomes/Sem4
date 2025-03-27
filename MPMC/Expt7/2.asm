section .data
    msg1 db 'Enter number: ', 0
    len1 equ $-msg1
    msg2 db 'The subtraction of the two numbers is ', 0
    len2 equ $-msg2
    msg3 db 'Enter the number of digits: ',0
    len3 equ $-msg3
    newline db 10
    l equ $-newline
    ten dd 10
    minus db '-', 0
    len_minus equ $-minus
    
%macro readsystem 2
    mov eax, 3
    mov ebx, 0
    mov ecx, %1
    mov edx, %2
    int 80h
%endmacro
%macro writesystem 2
    mov eax, 4
    mov ebx, 1
    mov ecx, %1
    mov edx, %2
    int 80h
%endmacro

section .bss
    num1 resb 10
    num2 resb 10
    n1 resb 2
    n2 resb 2
    result resb 10
    is_negative resb 8
    
section .text
    global _start
_start:    
    writesystem msg3, len3
    readsystem n1, 2
  
    writesystem msg1, len1
    readsystem num1, 10
    
    writesystem msg3, len3
    readsystem n2, 2

    writesystem msg1, len1
    readsystem num2, 10

    mov esi, num1
    call atoi
    mov ebx, eax

    mov esi, num2
    call atoi
    mov ecx, eax

    cmp ebx, ecx
    jge no_swap
    
    xchg ebx,ecx
    
    mov byte [is_negative], 1

no_swap:
    clc  

    mov eax, ebx
    sbb eax, ecx

display_result:
    mov esi, result
    call itoa

    writesystem msg2, len2

    cmp byte [is_negative], 1
    jne not_negative
    writesystem minus, len_minus

not_negative:
    writesystem result, 10
    writesystem newline, l

    mov eax, 1
    mov ebx, 0
    int 80h

atoi:
    xor eax, eax
    xor ecx, ecx
    
atoi_loop:
    movzx edx, byte [esi + ecx]
    cmp edx, 10
    je atoi_done
    sub edx, '0'
    imul eax, eax, 10
    add eax, edx
    inc ecx
    jmp atoi_loop
    
atoi_done:
    ret

itoa:
    xor ecx, ecx
    
itoa_loop:
    xor edx, edx
    div dword [ten]
    add dl, '0'
    mov [esi + ecx], dl
    inc ecx
    test eax, eax
    jnz itoa_loop
    mov byte [esi + ecx], 0
    mov edi, esi
    add edi, ecx
    dec edi
    mov ebx, esi
    
itoa_reverse:
    cmp ebx, edi
    jge itoa_done_reverse
    mov al, [ebx]
    mov ah, [edi]
    mov [ebx], ah
    mov [edi], al
    inc ebx
    dec edi
    jmp itoa_reverse
    
itoa_done_reverse:
    ret
