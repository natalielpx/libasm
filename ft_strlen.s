; ===== FT_STRLEN ============================================================================ ;
;  Function  : ft_strlen.s
;  Prototype : size_t ft_strlen(const char * str);
;  Purpose   : Immitates (man 3 strlen)
;  Args      : rdi - pointer to string
;  Returns   : rax = length
;  Clobbers  : rax
;  Arch      : x86-64 Linux (System V ABI)
; ============================================================================================ ;

segment .text
	global	ft_strlen

ft_strlen:
	; --- initialisation ---
	xor rax, rax	; return value: length = 0

.count:

	; --- check if end of string ---
	cmp byte [rdi + rax], 0	; if null character (1 byte) reached
	je .return				; return
	
	; --- count character ---
	inc rax					; else increment
	jmp .count				; repeat

.return:
	ret