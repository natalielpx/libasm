; ===== FT_STRDUP ============================================================================ ;
;  Function  : ft_strdup.s
;  Prototype : char * ft_strdup(const char * s);
;  Purpose   : Immitates (man 3 strdup)
;  Args      : rdi - pointer to src
;  Returns   : rax = pointer to dup
;  Clobbers  : rax
;  Arch      : x86-64 Linux (System V ABI)
; ============================================================================================ ;

segment .text
	global	ft_strdup
	extern	malloc
	default	rel			; PIE-safe
	extern	ft_strlen
	extern	ft_strcpy

ft_strdup:

	; -- save s ptr in stack --
	push	rdi

	; -- obtain s string length --
	call	ft_strlen	; ft_strlen(s)

	; -- allocate length + 1 memory --
	inc		rax					; length + 1
	mov		rdi, rax			; arg1 = length + 1
	call	malloc wrt ..plt	; malloc(length + 1) with respect to procedure linkage table entry

	; -- if malloc failed --
	test	rax, rax
	jz		.return

	; -- copy from s to memory obtained via malloc --
	pop		rdi			; restore s ptr from stack
	mov		rsi, rdi	; set s as arg2
	mov		rdi, rax	; set dup as arg1
	call	ft_strcpy	; ft_strcpy(dup, s)

.return:
	ret