section .data
	lf equ 10
	null equ 0
	sys_write equ 4
	sys_exit equ 1
	stdout equ 1
	
	msg1 db 'Hello, here.',lf,null
	msg1_len equ $ - msg1 - 1
	
	msg2 db 'Using equ directive',lf,null
	msg2_len equ $ - msg2 - 1
section .text
	global _start
_start:
	mov eax,sys_write
	mov ebx,stdout
	mov ecx,msg1
	mov edx,msg1_len
	int 0x80
	
	mov eax,sys_write
	mov ebx,stdout
	mov ecx,msg2
	mov edx,msg2_len
	int 0x80
	
	mov eax,sys_exit
	xor ebx,ebx
	int 0x80
