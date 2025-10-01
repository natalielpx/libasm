; ===== FT_STRCMP ============================================================================ ;
;  Function  : ft_strcmp.s
;  Prototype : int ft_strcmp(const char * s1, const char * s2);
;  Purpose   : Immitates (man 3 strcmp)
;  Args      : rdi - pointer to dst, rsi - pointer to src
;  Returns   : rax = pointer to dst
;  Arch      : x86-64 Linux (System V ABI)
; ============================================================================================ ;

section .text
	global	ft_strcmp

ft_strcmp:

.compare:
; --- copy s1* & s2* int ---
	; operations cannot be conducted between 2 memory values
	; target memory values are stored in registers (rax, rdx) for future operations
	movzx eax, byte [rdi]	; moves lowest byte from rdi to zero extended (initialised) 32bits, which in x86-64 is extended to 64bits
	movzx edx, byte [rsi]
	; rax now contains *s1
	; rdx now contains *s2
; --- compare current characters of strings ---
	cmp rax, rdx	; if s1* != s2*
	jne .diff		; find difference
; --- check if end of strings ---
	; rax is zero extended
	test rax, rax	; if null reached
	jz .return		; return
; --- else increment and repeat ---
	inc rsi			; ++s1
	inc rdi			; ++s2
	jmp .compare	; repeat

.diff:
; --- caluclate difference between the characters ---
	; rax = rax - rdx
	sub rax, rdx	; s1* - s2*

.return:
	; rax = 0 if null reached
	; rax = s1* - s2* (difference)
	ret