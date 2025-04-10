section .data
	msg1 db 'Enter length of rectangle: '
	m1Len equ $-msg1
	msg2 db 'Enter breadth of rectangle: '
	m2Len equ $-msg2
	msg3 db 'Perimeter = '
	m3Len equ $-msg3
	msg4 db 'Area = '
	m4Len equ $-msg4
	msg db ' ',10
	len equ $-msg
	msg5 db 'Enter side 1 of triangle:'
	m5Len equ $-msg5
	msg6 db 'Enter side 2 of triangle:'
	m6Len equ $-msg6
	msg7 db 'Enter side 3 of triangle:'
	m7Len equ $-msg7
	msg8 db 'Enter height of triangle:'
	m8Len equ $-msg8
	msg9 db 'Enter base of triangle:'
	m9Len equ $-msg9
section .bss
	r_len RESB 1
	r_bred RESB 1
	r_area RESB 1
	r_peri RESB 1
	t_s1 RESB 5
	t_s2 RESB 5
	t_s3 RESB 5
	t_base RESB 5
	t_ht RESB 5
	t_area RESB 5
	t_peri RESB 5
section .text
	global _start:
_start:
	mov eax,4 ;input
	mov ebx,1
	mov ecx,msg1
	mov edx,m1Len
	int 80h
	
	mov eax,3
	mov ebx,2
	mov ecx,r_len
	mov edx,10
	int 80h
	
	mov eax,4
	mov ebx,1
	mov ecx,msg2
	mov edx,m2Len
	int 80h
	
	mov eax,3
	mov ebx,2
	mov ecx,r_bred
	mov edx,10
	int 80h
	
	mov eax,[r_len]
	sub eax, '0'
	mov ebx,[r_bred]
	sub ebx, '0'
	add eax, ebx
	
	mov ebx, 2
	mul ebx
	add eax, '0'
	mov [r_peri], eax
	int 80h
	
	mov eax, 4
	mov ebx,1
	mov ecx, msg3
	mov edx, m3Len
	int 80h
	
	mov eax, 4
	mov ebx,1
	mov ecx, r_peri
	mov edx, 1
	int 80h
	
	mov eax, 4
	mov ebx,1
	mov ecx, ' '
	mov edx, 1
	int 80h
	
	mov eax, [r_len]
	sub eax, '0'
	mov ebx,[r_bred]
	sub ebx, '0'
	mul ebx
	add eax, '0'
	mov [r_area], eax
	int 80h
	
	mov eax, 4	
	mov ebx,1
	mov ecx, msg
	mov edx, len
	int 80h
	
	mov eax, 4
	mov ebx,1
	mov ecx, msg4
	mov edx, m4Len
	int 80h
	
	mov eax, 4
	mov ebx,1
	mov ecx, r_area
	mov edx, 1
	int 80h
	
	mov eax, 4
	mov ebx,1
	mov ecx, msg
	mov edx, len
	int 80h
	mov eax,4 ;input
	mov ebx,1
	mov ecx,msg5
	mov edx,m5Len
	int 80h
	
	mov eax,3
	mov ebx,2
	mov ecx,t_s1
	mov edx,5
	int 80h
	
	mov eax,4
	mov ebx,1
	mov ecx,msg6
	mov edx,m6Len
	int 80h
	
	mov eax,3
	mov ebx,2
	mov ecx,t_s2
	mov edx,5
	int 80h
	
	mov eax,4
	mov ebx,1
	mov ecx,msg7
	mov edx,m7Len
	int 80h
	
	mov eax,3
	mov ebx,2
	mov ecx,t_s3
	mov edx,5
	int 80h
	
	mov eax,4
	mov ebx,1
	mov ecx,msg8
	mov edx,m8Len
	int 80h
	
	mov eax,3
	mov ebx,2
	mov ecx,t_ht
	mov edx,5
	int 80h
	
	mov eax,4
	mov ebx,1
	mov ecx,msg9
	mov edx,m9Len
	int 80h
	
	mov eax,3
	mov ebx,2
	mov ecx,t_base
	mov edx,5
	int 80h
	
	mov eax, [t_s1]
	sub eax, '0'
	mov ebx, [t_s2]
	sub ebx, '0'
	add eax, ebx
	
	mov ebx, [t_s3]
	sub ebx, '0'
	add eax,ebx
	add eax, '0'
	mov [t_peri], eax
	int 80h
	
	mov eax, 4
	mov ebx,1
	mov ecx, msg3
	mov edx, m3Len
	int 80h
	
	mov eax, 4
	mov ebx,1
	mov ecx, t_peri
	mov edx, 1
	int 80h
	
	mov eax, 4
	mov ebx,1
	mov ecx, msg
	mov edx, len
	int 80h
	
	mov eax, [t_base]
	sub eax, '0'
	mov ebx, [t_ht]
	sub ebx, '0'
	mul ebx
	mov [t_area], eax
	int 80h
	
	mov al, [t_area]
	mov bl, 2
	cbw
	div bl
	add al, '0'
	mov [t_area], al
	int 80h
	
	mov eax, 4
	mov ebx,1
	mov ecx, msg4
	mov edx, m4Len
	int 80h
	
	mov eax, 4
	mov ebx,1
	mov ecx, t_area
	mov edx, 1
	int 80h
	
	mov eax, 4
	mov ebx,1
	mov ecx, msg
	mov edx, len
	int 80h
	
	mov eax, 1
	mov ebx, 0
	int 80h
