section .data
	msg db ' ',10
	msg_len equ $ - msg
	msg1 db 'Number 1: '
	msg1_len equ $ - msg1
	msg2 db 'Number 2: '
	msg2_len equ $ - msg2
	msg3 db 'Sum: '
	msg3_len equ $ - msg3
	newline db 10,0
	
	sysw equ 4
	sysr equ 3
	syse equ 1
	stdout equ 1
	stde equ 0
	stdin equ 2

section .bss
	num1 resb 5
	num2 resb 5
	sum resb 5

section .text
	global _start
_start:
	mov eax,sysw
	mov ebx,stdout
	mov ecx,msg1
	mov edx,msg1_len
	int 0x80
	
	mov eax,sysr
	mov ebx,stdin
	mov ecx,num1
	mov edx,5
	int 0x80
	
	mov eax,sysw
	mov ebx,stdout
	mov ecx,msg2
	mov edx,msg2_len
	int 0x80
	
	mov eax,sysr
	mov ebx,stdin
	mov ecx,num2
	mov edx,5
	int 0x80
	
	mov eax,[num1]
	sub eax,'0'
	mov ebx,[num2]
	sub ebx,'0'
	add eax,ebx
	add eax,'0'
	mov [sum],eax
	
	mov eax,sysw
	mov ebx,stdout
	mov ecx,msg3
	mov edx,msg3_len
	int 0x80
	
	mov eax,sysw
	mov ebx,stdout
	mov ecx,sum
	mov edx,5
	int 0x80
	
	mov eax,sysw
	mov ebx,stdout
	mov ecx,newline
	mov edx,10
	int 0x80
	
	mov eax,1
	xor ebx,ebx
	int 0x80
