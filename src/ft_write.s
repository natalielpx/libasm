; ===== FT_WRITE ============================================================================= ;
;  Function  : ft_write.s
;  Prototype : ssize_t ft_write(int fd, const void *buf, size_t count);
;  Purpose   : Immitates (man 2 write)
;  Args      : rdi - output fd, rsi - ptr to str, rdx - number of chars to write
;  Returns   : rax = number of chars written
;  Arch      : x86-64 Linux (System V ABI)
; ============================================================================================ ;

SYS_WRITE	equ 1

default	rel	; PIE-safe
extern	__errno_location

section .text
	global	ft_write

ft_write:
	; rdi = fd
	; rsi = buf
	; rdx = count
	mov rax, SYS_WRITE
	syscall				; call system kernel
    cmp rax, 0			; if result < 0
    jl .error          	; set errno

.return:
	; rax = bytes written (success)
	; rax = -1 (error)
	ret

.error:
    neg rax				; rax = -rax (= errno value)
	push rax			; save errno value to stack
	; int * __errno_location(void)
    call __errno_location wrt ..plt
	pop rdx				; restore errno value from stack
	mov [rax], rdx		; store errno value into *errno
    mov rax, -1			; return value = -1
	jmp .return