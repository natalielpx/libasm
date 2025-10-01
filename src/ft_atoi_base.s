; ===== FT_ATOI_BASE ========================================================================= ;
;  Function  : ft_atoi_base.s
;  Prototype : int ft_atoi_base(const char * str, int base);
;  Purpose   : converts string argument to base 10 integer and returns it
;  Args      : rdi - string, rsi - base
;  Returns   : base 10 integer
;  Clobbers  : rax, rcx, rbx, rdi ,rsi, r8, r9, r10
;  Arch      : x86-64 Linux (System V ABI)
; ============================================================================================ ;

%define INT dword

default rel
extern  __errno_location

segment .rodata
    digits_a db '0123456789abcdef', 0
    digits_A db '0123456789ABCDEF', 0

segment .text
    global  ft_atoi_base

ft_atoi_base:

; ===== INITIALISATION =====
    xor rax, rax
    push rbx

; ===== PARSING =====

.valid_base:
    cmp rsi, 2
    jl .return
    cmp rsi, 16
    jg .return

.skip_white:
    movzx r8, byte [rdi]
    cmp r8, 0
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
    xor rbx, rbx
    cmp r8, '-'
    jne .valid_digit
    mov rbx, -1
    inc rdi

.valid_digit:
    lea r9, [digits_a]
    lea r10, [digits_A]
    xor rcx, rcx
.repeat_valid_digit:
    movzx r8, byte [rdi]
    cmp r8, 0x00
    je .negate
    movzx r11, byte [r9 + rcx]
    cmp r8, r11
    je .obtain_value
    movzx r11, byte [r10 + rcx]
    cmp r8, r11
    je .obtain_value
    inc rcx
    cmp rcx, rsi
    jge .negate
    jmp .repeat_valid_digit

; ===== OPERATIONS =====

.obtain_value:
    cmp r8, 'a'
    jge .minus_a
    cmp r8, 'A'
    jge .minus_A
    sub r8, '0'
    jmp .calculate
.minus_a:
    sub r8, 'a'
    add r8, 10
    jmp .calculate
.minus_A:
    sub r8, 'A'
    add r8, 10
    jmp .calculate

.calculate:
    mul rsi             ; clobbers rdx !!!
    add rax, r8
    inc rdi
    jmp .valid_digit

.negate:
    test rbx, rbx
    jz .return
    neg rax

; ===== RETURN =====

.return:
    pop rbx
    ret