; ===== FT_READ ============================================================================= ;
;  Function  : ft_read.s
;  Prototype : ssize_t ft_read(int fd, void * buf, size_t count);
;  Purpose   : Immitates (man 2 read)
;  Args      : rdi - input fd, rsi - ptr to buf, rdx - number of chars to read
;  Returns   : rax = number of chars written
;  Arch      : x86-64 Linux (System V ABI)
; ============================================================================================ ;

SYS_READ	equ 0

default	rel	; PIE-safe
extern	__errno_location

section .text
	global	ft_read

ft_read:
	; rdi = fd
	; rsi = buf
	; rdx = count
	mov rax, SYS_READ
	syscall					; call system kernel
    cmp rax, 0				; if result < 0
    jl .error            	; set errno

.return:
	; rax = bytes read (success)
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