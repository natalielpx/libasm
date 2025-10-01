; ===== FT_STRCPY ============================================================================ ;
;  Function  : ft_strcpy.s
;  Prototype : char * ft_strcpy(char * dst, const char * src);
;  Purpose   : Immitates (man 3 strcpy)
;  Args      : rdi - pointer to dst, rsi - pointer to src
;  Returns   : rax = pointer to dst
;  Arch      : x86-64 Linux (System V ABI)
; ============================================================================================ ;

section .text
	global	ft_strcpy

ft_strcpy:
; --- store dst address for return ---
	; rdi = arg1 (address of destination)
	mov rax, rdi	; return value: dst (pointer)

.copy:
; --- copy current byte from src to dst ---
	; operations cannot be conducted between 2 memory values
	; bl is the lowest 8 bits (1 byte = 1 char) of the rbx register
	mov bl, [rsi]	; copy *src to register
	mov [rdi], bl	; copy register to *dst
; --- check if end of string ---
	; only the lowest 8 bits is checked, to avoid garbage values in the higher bits
	test bl, bl		; if null reached
	jz .return		; return
; --- increment and repeat ----
	; rax already contains the initial dst, and will not be affected
	inc rsi			; else ++src
	inc rdi			; ++ dst
	jmp .copy		; repeat

.return:
	; rax = (unmodified) address of dst
	ret