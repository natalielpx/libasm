; ===== FT_READ ============================================================================= ;
;  Function  : ft_read.s
;  Prototype : ssize_t ft_read(int fd, void * buf, size_t count);
;  Purpose   : Immitates (man 2 read)
;  Args      : rdi - input fd, rsi - ptr to buf, rdx - number of chars to read
;  Returns   : rax = number of chars written
;  Clobbers  : rax
;  Arch      : x86-64 Linux (System V ABI)
; ============================================================================================ ;

SYS_READ	equ 0

segment .text
	global	ft_read

ft_read:

	mov rax, SYS_READ
	syscall

.return:
	ret