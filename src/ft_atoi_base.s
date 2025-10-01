; ===== FT_ATOI_BASE ========================================================================= ;
;  Function  : ft_atoi_base.s
;  Prototype : int ft_atoi_base(const char * str, int base);
;  Purpose   : converts string argument to base 10 integer and returns it
;  Args      : rdi - string, rsi - base
;  Returns   : base 10 integer
;  Arch      : x86-64 Linux (System V ABI)
; ============================================================================================ ;

%define INT dword

default rel
extern  __errno_location

section .rodata
    digits_a db '0123456789abcdef', 0	; lowercase hex
    digits_A db '0123456789ABCDEF', 0	; uppercase hex

section .text
    global  ft_atoi_base

ft_atoi_base:

; ===== INITIALISATION =====

; --- initialise return value ---
    xor rax, rax	; return value = 0

; --- push callee saved registers ---
    push rbx		; push rbx to stack

; ===== PARSING =====

.valid_base:
; --- ensure 2 <= base <= 16
    cmp rsi, 2		; if base < 2
    jl .return		; return
    cmp rsi, 16		; else if base > 16
    jg .return		; return

.skip_white:
; --- obtain *str ---
    movzx r8, byte [rdi]		; store *str in register (faster than repeatedly reading from memory)
; --- check if null reached ---
    cmp r8, 0					; if *str == 0
    je .return					; return
; --- check for white spaces ---
    cmp r8, ' '					; if *str == ' '
    je .repeat_skip_white		; repeat
    cmp r8, 9					; if *str < 9
    jl .check_neg				; advance
    cmp r8, 13					; if *str > 13
    jg .check_neg				; advance
.repeat_skip_white:
; --- increment and loop ---
    inc rdi						; ++str
    jmp .skip_white				; return to beginning of loop

.check_neg:
; --- check for negative sign ---
    xor rbx, rbx		; assume non-negative
    cmp r8, '-'			; if *str != '-'
    jne .digits	; advance
    mov rbx, -1			; store negative sign
    inc rdi				; ++str

.digits:
; --- get digit references ---
    lea r9, [digits_a]		; get lowercase hex digits
    lea r10, [digits_A]		; get uppercase hex digits

.valid_digit:
; --- initialise counter ---
    xor rcx, rcx				; counter = 0
.repeat_valid_digit:
; --- check for match (valid) ---
    movzx r8, byte [rdi]		; store *str in register
    test r8, r8					; if *str == 0
    je .negate					; prepare to return value
    movzx r11, byte [r9 + rcx]	; store *digits_a in register
    cmp r8, r11					; if *str == *digits_a
    je .obtain_value			; advance
    movzx r11, byte [r10 + rcx]	; store *digits_A in register
    cmp r8, r11					; if *str == *digits_A
    je .obtain_value			; advance
; --- move on to next digit reference ---
    inc rcx					; ++counter
    cmp rcx, rsi			; if counter >= base
    jge .negate				; digit is invalid, prepare to return value
    jmp .repeat_valid_digit ; else repeat

; ===== OPERATIONS =====

.obtain_value:
; --- obtain numerical value of *str ---
    cmp r8, 'a'		; if *str >= 'a'
    jge .minus_a	; 'a' <= *str 'f'
    cmp r8, 'A'		; else if *str >= 'A'
    jge .minus_A	; 'A' <= *str 'F'
    sub r8, '0'		; else '0' <= *str <= '9'
    jmp .calculate
.minus_a:
; --- *str - 'a' + 10 ---
    sub r8, 'a'
    add r8, 10
    jmp .calculate
.minus_A:
; --- *str - 'A' + 10 ---
    sub r8, 'A'
    add r8, 10
    jmp .calculate

.calculate:
; --- calculate value thusfar ---
	; sum = sum * base + digit
	; !!! MUL CLOBBERS RDX !!!
    mul rsi             ; rax = rax * rsi (sum * base)
    add rax, r8			; add value of *str
    inc rdi				; ++str
    jmp .valid_digit	; repeat

.negate:
    test rbx, rbx		; if sign == 0
    jz .return			; return sum
    neg rax				; else negate sum

; ===== RETURN =====

.return:
; --- restore callee saved registers ---
    pop rbx
; --- return calculated value ---
    ret