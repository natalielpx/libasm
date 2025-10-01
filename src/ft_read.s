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

default	rel	; PIE-safe
extern	__errno_location

segment .text
	global	ft_read

ft_read:
	mov rax, SYS_READ
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