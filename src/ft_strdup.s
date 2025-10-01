; ===== FT_STRDUP ============================================================================ ;
;  Function  : ft_strdup.s
;  Prototype : char * ft_strdup(const char * s);
;  Purpose   : Immitates (man 3 strdup)
;  Args      : rdi - pointer to src
;  Returns   : rax = pointer to dup
;  Arch      : x86-64 Linux (System V ABI)
; ============================================================================================ ;

%define	INT	dword

ENOMEM	equ 12

default	rel			; PIE-safe
extern	malloc
extern	__errno_location
extern	ft_strlen
extern	ft_strcpy

section .text
	global	ft_strdup

ft_strdup:
; --- save s ptr in stack ---
	push	rdi
; --- obtain length of s ---
 	; size_t ft_strlen(const char * str);
	; rdi = s;
	call	ft_strlen			; ft_strlen(s)
	; rax = length of s;
; --- allocate length + 1 memory ---
	inc		rax					; length + 1
	mov		rdi, rax			; arg1 = length + 1
	; void *malloc(size_t size);
	; rdi = length + 1
	call	malloc wrt ..plt	; malloc(length + 1) with respect to procedure linkage table entry
	; rax = pointer to allocated memory
; --- check if malloc failed ---
	test	rax, rax	; if malloc returned null
	jz		.error		; set errno
; --- copy from s to memory obtained via malloc ---
	pop		rdi			; restore s ptr from stack
	mov		rsi, rdi	; set s as arg2 (src)
	mov		rdi, rax	; set dup as arg1 (dst)
	; char * ft_strcpy(char * dst, const char * src);
	; rdi = dup
	; rsi = s
	call	ft_strcpy	; ft_strcpy(dup, s)

.return:
	; rax = dup (success)
	; rax = NULL (failure)
	ret

.error:
	; int * __errno_location(void)
    call __errno_location wrt ..plt
    mov [rax], INT ENOMEM	; *errno (4 bytes) = error number
	mov rax, 0				; set rax = NULL
	jmp .return