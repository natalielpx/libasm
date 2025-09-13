; ===== FT_WRITE ============================================================================= ;
;  Function  : ft_write.s
;  Prototype : ssize_t write(int fd, const void *buf, size_t count);
;  Purpose   : Immitates (man 2 write)
;  Args      : rdi - output fd, rsi - ptr to str, rdx - number of chars to write
;  Returns   : rax = number of chars written
;  Clobbers  : rax
;  Arch      : x86-64 Linux (System V ABI)
; ============================================================================================ ;

SYS_WRITE	equ 1

segment .text
	global	ft_write

ft_write:

	mov rax, SYS_WRITE
	syscall

.return:
	ret