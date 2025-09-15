; ===== FT_STRCMP ============================================================================ ;
;  Function  : ft_strcmp.s
;  Prototype : int ft_strcmp(const char * s1, const char * s2);
;  Purpose   : Immitates (man 3 strcmp)
;  Args      : rdi - pointer to dst, rsi - pointer to src
;  Returns   : rax = pointer to dst
;  Clobbers  : rax
;  Arch      : x86-64 Linux (System V ABI)
; ============================================================================================ ;

segment .text
	global	ft_strcmp

ft_strcmp:

.repeat:

	; -- copy s1* & s2* int --
	movzx eax, byte [rdi]	; moves lowest byte from rdi to zero extended (initialised) 32bits, which in x86-64 is extended to 64bits
	movzx edx, byte [rsi]

	; -- if s1* != s2*, find difference --
	cmp rax, rdx
	jne .diff

	; -- if null reached, return --
	test rax, rax
	jz .return

	; -- else increment and repeat --
	inc rsi
	inc rdi
	jmp .repeat

.diff:
	sub rax, rdx

.return:
	ret