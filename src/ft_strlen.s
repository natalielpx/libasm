; ===== FT_STRLEN ============================================================================ ;
;  Function  : ft_strlen.s
;  Prototype : size_t ft_strlen(const char * str);
;  Purpose   : Immitates (man 3 strlen)
;  Args      : rdi - pointer to string
;  Returns   : rax = length
;  Arch      : x86-64 Linux (System V ABI)
; ============================================================================================ ;

%define	CHAR byte

section .text
	global	ft_strlen

ft_strlen:
; --- initialisation ---
	; rax = return value
	xor rax, rax	; return value: len = 0

.count:
; --- check if end of string ---
	; rdi = arg1
	cmp CHAR [rdi + rax], 0	; if *(str + len) == 0
	je .return				; return
; --- count character ---
	inc rax		; else ++len
	jmp .count	; repeat

.return:
	; rax = length of str
	ret