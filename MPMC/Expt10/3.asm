%macro write 2
    mov eax,4         
    mov ebx,1     
    mov ecx,%1     
    mov edx,%2       
    int 80h   
%endmacro

%macro read 2
    mov eax,3        
    mov ebx,2        
    mov ecx,%1       
    mov edx,%2       
    int 80h
    
    mov eax,3         
    mov ebx,2        
    mov ecx,trash     
    mov edx,1         
    int 80h          
%endmacro

section .data
    msg2 db "Enter the elements in the array: "
    msg2len equ $-msg2
    msg3 db "The sorted array is: "
    msg3len equ $-msg3
    msg4 db "Pass "
    msg4len equ $-msg4
    msg5 db ": "
    msg5len equ $-msg5
    newline db 10
    space db ' '
    n db 5

section .bss
    arr resb 5
    i resb 1
    pass_num resb 1
    temp resb 1
    trash resb 1          
    min_idx resb 1

section .text
    global _start

_start:
    call input               
    write newline, 1         
    call selection_sort      
    write newline, 1         
    write msg3, msg3len      
    call display
    
    mov eax, 1              
    mov ebx, 0              
    int 80h

input:
    write msg2,msg2len      
    mov [i], byte 0       
loop1:
    movzx esi, byte [i]   
    cmp esi, 5            
    jge end1              
    lea esi, [arr + esi]  
    read esi, 1           
    inc byte [i]          
    jmp loop1              
end1:
    ret                  

display:
    mov [i], byte 0       
loop2:
    movzx esi, byte [i]   
    cmp esi, 5            
    jge end2              
    lea esi, [arr + esi]  
    write esi, 1          
    write space, 1        
    inc byte [i]          
    jmp loop2              
end2:
    write newline, 1      
    ret                   

selection_sort:
    mov byte [pass_num], '1'
    mov al, 0
outer_loop:
    cmp al, 4
    jge sort_end
    
    pushad
    write msg4, msg4len
    mov cl, [pass_num]
    mov [temp], cl
    write temp, 1
    write msg5, msg5len
    call display
    popad
    
    mov [min_idx], al
    mov cl, al
    inc cl

find_min:
    cmp cl, 5
    jge swap_min
    
    movzx esi, cl
    movzx edi, byte [min_idx]
    mov bl, [arr + esi]
    mov bh, [arr + edi]
    cmp bl, bh
    jge no_update_min
    
    mov [min_idx], cl

no_update_min:
    inc cl
    jmp find_min

swap_min:
    movzx esi, al
    movzx edi, byte [min_idx]
    mov bl, [arr + esi]
    mov bh, [arr + edi]
    mov [arr + esi], bh
    mov [arr + edi], bl
    
    inc al
    inc byte [pass_num]
    jmp outer_loop

sort_end:
    write msg4, msg4len
    mov cl, [pass_num]
    mov [temp], cl
    write temp, 1
    write msg5, msg5len
    call display
    ret

