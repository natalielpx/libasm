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

.compare:

	; -- copy s1* & s2* int --
	movzx eax, byte [rdi]	; moves lowest byte from rdi to zero extended (initialised) 32bits, which in x86-64 is extended to 64bits
	movzx edx, byte [rsi]

	; -- compare current characters of strings --
	cmp rax, rdx	; if s1* != s2*
	jne .diff		; find difference
	
	; -- check if end of strings --
	test rax, rax	; if null reached
	jz .return		; return
	
	; -- else increment and repeat --
	inc rsi			; ++s1
	inc rdi			; ++s2
	jmp .compare	; repeat

.diff:
	sub rax, rdx	; rax = s1* - s2*

.return:
	ret