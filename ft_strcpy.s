; ===== FT_STRCPY ============================================================================ ;
;  Function  : ft_strcpy.s
;  Prototype : char * ft_strcpy(char * dst, const char * src);
;  Purpose   : Immitates (man 3 strcpy)
;  Args      : rdi - pointer to dst, rsi - pointer to src
;  Returns   : rax = pointer to dst
;  Clobbers  : rax
;  Arch      : x86-64 Linux (System V ABI)
; ============================================================================================ ;

segment .text
	global	ft_strcpy

ft_strcpy:
	; --- store dst address for return ---
	mov rax, rdi	; return value: dst (pointer)

.copy:

	; --- copy current byte from src to dst ---
	mov bl, [rsi]	; copy src* to register
	mov [rdi], bl	; copy register to dst*

	; --- check if end of string ---
	test bl, bl		; if null reached
	jz .return		; return
	
	; --- increment and repeat ----
	inc rsi			; else ++src
	inc rdi			; ++ dst
	jmp .copy		; repeat

.return:
	ret