; ===== FT_STRLEN ============================================================================ ;
;  Function  : ft_strlen.asm
;  Prototype : size_t ft_strlen(const char *str)
;  Purpose   : Immitates (man 3 strlen)
;  Args      : rdi - pointer to string
;  Returns   : rax = length
;  Clobbers  : rax
;  Arch      : x86-64 Linux (System V ABI)
; ============================================================================================ ;

segment .text
	global	ft_strlen

ft_strlen:
	xor rax, rax	; clear register (initialise rax = 0) 
.repeat:
	cmp byte [rdi + rax], 0
	je .done
	inc rax
	jmp .repeat
.done:
	ret