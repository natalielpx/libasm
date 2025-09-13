; ===== FT_STRCPY ============================================================================ ;
;  Function  : ft_strcpy.s
;  Prototype : char * ft_strcpy(char * dst, const char * src);
;  Purpose   : Immitates (man 3 strcpy)
;  Args      : rdi - pointer to dst, rsi pointer to src
;  Returns   : rax = pointer to dst
;  Clobbers  : rax
;  Arch      : x86-64 Linux (System V ABI)
; ============================================================================================ ;

segment .text
	global	ft_strcpy

ft_strcpy:

	; -- store dst address for return --
	mov rax, rdi

.repeat:

	; -- copy current byte from src to dst --
	mov bl, [rsi]
	mov [rdi], bl

	; -- if null reached, return --
	test bl, bl		; check if 0
	jz .return

	; -- else increment and repeat --
	inc rsi
	inc rdi
	jmp .repeat

.return:
	ret