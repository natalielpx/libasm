; ===== FT_WRITE ============================================================================= ;
;  Function  : ft_write.s
;  Prototype : ssize_t ft_write(int fd, const void *buf, size_t count);
;  Purpose   : Immitates (man 2 write)
;  Args      : rdi - output fd, rsi - ptr to str, rdx - number of chars to write
;  Returns   : rax = number of chars written
;  Clobbers  : rax
;  Arch      : x86-64 Linux (System V ABI)
; ============================================================================================ ;

SYS_WRITE	equ 1

default	rel	; PIE-safe
extern	__errno_location

segment .text
	global	ft_write

ft_write:
	mov rax, SYS_WRITE
	syscall					; call system kernel
    cmp rax, 0				; if result < 0
    jl .error            	; set errno

.return:
	ret

.error:
    neg rax                ; rax = -rax (= errno value)
    mov edi, eax
    call __errno_location wrt ..plt
    mov [rax], edi         ; *errno (4 bytes) = error number
    mov rax, -1            ; return value = -1
	jmp .return