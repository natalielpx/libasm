%define INT dword

default rel
extern __errno_location

segment .rodata
    digits db '0123456789abcdef', 0

segment .text
    global  ft_atoi_base

ft_atoi_base:
    xor rax, rax

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
    jne .convert
    mov rdx, -1
    inc rdi

.convert:
    push rdx
    call convert
    pop rdx

.negate:
    test rdx, rdx
    jz .return
    neg rax

.return:
    ret


convert:
    movzx r8, byte [rdi]
    cmp r8, 0x00
    je .return

.valid_digit:		  
    lea r9, [digits]
    xor rcx, rcx
.repeat_valid_digit:
    movzx r10, byte [r9 + rcx]
    cmp r8, r10
    je .obtain_value
    inc rcx
    cmp rcx, rsi
    jge .return
    jmp .repeat_valid_digit

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
    call convert

.return:
    ret