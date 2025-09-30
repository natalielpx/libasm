; ===== FT_ATOI_BASE ========================================================================= ;
;  Function  : ft_atoi_base.s
;  Prototype : int ft_atoi_base(const char * str, int str_base);
;  Purpose   : converts string argument to base 10 integer and returns it
;  Args      : rdi - string, rsi - base
;  Returns   : base 10 integer
;  Clobbers  : rax, rcx, rdx, rdi ,rsi, r8, r9, r10
;  Arch      : x86-64 Linux (System V ABI)
; ============================================================================================ ;

%define INT dword

default rel
extern  __errno_location

segment .rodata
    digits db '0123456789abcdef', 0

segment .text
    global  ft_atoi_base

ft_atoi_base:

; ===== INITIALISATION =====
    xor rax, rax

; ===== PARSING =====

.valid_base:
    cmp rsi, 2
    jl .return
    cmp rsi, 16
    jg .return

.skip_white:
    movzx r8, byte [rdi]
    cmp r8, 0x00
    je .return
    cmp r8, ' '
    je .repeat_skip_white
    cmp r8, 9
    jl .check_neg
    cmp r8, 13
    jg .check_neg
.repeat_skip_white:
    inc rdi
    jmp .skip_white

.check_neg:
    xor rdx, rdx
    cmp r8, '-'
    jne .valid_digit
    mov rdx, -1
    inc rdi

.valid_digit:
    lea r9, [digits]
    xor rcx, rcx
.repeat_valid_digit:
    movzx r8, byte [rdi]
    cmp r8, 0x00
    je .return
    movzx r10, byte [r9 + rcx]
    cmp r8, r10
    je .obtain_value
    inc rcx
    cmp rcx, rsi
    jge .return
    jmp .repeat_valid_digit

; ===== OPERATIONS =====

.obtain_value:
    cmp r8, 'a'
    jge .minus_a
    sub r8, '0'
    jmp .calculate
.minus_a:
    sub r8, 'a'
    add r8, 10
    jmp .calculate

.calculate:
    mul rsi
    add rax, r8
    inc rdi
    jmp .valid_digit

.negate:
    test rdx, rdx
    jz .return
    neg rax

; ===== RETURN =====

.return:
    ret

; ; ===== FUNCTION(S) =====

; convert:

; ; ===== INITIALISATION =====
;     movzx r8, byte [rdi]
;     cmp r8, 0x00
;     je .return

; ; ===== PARSING =====

; .valid_digit:
;     lea r9, [digits]
;     xor rcx, rcx
; .repeat_valid_digit:
;     movzx r10, byte [r9 + rcx]
;     cmp r8, 0x00
;     je .return
;     cmp r8, r10
;     je .obtain_value
;     inc rcx
;     cmp rcx, rsi
;     jge .return
;     jmp .repeat_valid_digit

; ; ===== OPERATIONS =====

; .obtain_value:
;     cmp r8, 'a'
;     jge .minus_a
;     sub r8, '0'
;     jmp .calculate
; .minus_a:
;     sub r8, 'a'
;     add r8, 10
;     jmp .calculate

; .calculate:
;     mul rsi
;     add rax, r8
;     inc rdi
;     call convert

; ; ===== RETURN =====

; .return:
;     ret