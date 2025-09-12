; ===== MAIN ============================================================================ ;
;  Program  : main.asm
;  Purpose	: Tester for libasm
; ============================================================================================ ;
;  Architecture : x86-64
;  OS / ABI     : Linux
;  Assembler    : NASM syntax
;  Build        : nasm -f elf64 main.asm -o main.o
;  				  ld main.o -o main
;  Run          : ./main
;  Exit         : 0 on success
; ============================================================================================ ;
;  Syscall   : rax = syscall number
;  Arguments : rdi, rsi, rdx, r10, r8, r9
;  Return    : rax
;  Remarks   : r10 is used because Linux syscalls overwrite rcx
; ============================================================================================ ;

; ----- System Call Numbers -----
SYS_WRITE	equ 1
SYS_EXIT	equ 60

; ----- File Descriptors --------
STD_OUT		equ 1

; ----- Macros ------------------
%macro write_string  2
	mov rax, SYS_WRITE
	mov rdi, STD_OUT
	mov rsi, %1
	mov rdx, %2
	syscall
%endmacro

; ----- Memory Declarations -----
segment .data
	str 	:	db 'aef0kaehdkhf\as', 0	; Null-terminated string
	len_str		equ $-str - 1				; Actual length of string
	suc 	:	db 'SUCCESS', 0xa		; Success message
	len_suc		equ $-suc
	flr 	:	db 'FAILURE', 0xa		; Failure message
	len_flr		equ $-flr
	newl 	:	db 0xa					; Just a newline

; ----- Memory Reservation -----
segment .bss
	res		resd 1
	dst		resb len_str + 1

; ----- Instruction Code --------
segment .text
	global	_start
	extern	ft_strlen
	extern	ft_strcpy

; ----- Entry Point -------------
_start:

; == FT_STRLEN ==
.test_strlen:

	; -- write string --
	write_string str, len_str
	write_string newl, 1

	; -- res = ft_strlen(str) --
	mov rdi, str	; arg1 = str address
	call ft_strlen
	mov	[res], rax	; stores result in res

	; -- compare results --
	cmp	dword [res], len_str
	jne	.failure
.success:
	write_string suc, len_suc
	jmp	.test_strcpy
.failure:
	write_string flr, len_flr

; == FT_STRLEN ==
.test_strcpy:

	; -- write string --
	write_string str, len_str
	write_string newl, 1

	; -- res = ft_strcpy(dst, src) --
	mov rsi, str	; arg2 = str address
	mov rdi, dst	; arg1 = dst buffer
	call ft_strcpy

	; -- write result --
	write_string dst, len_str
	write_string newl, 1

.exit:
	; -- exit(EXIT_SUCCESS) --
	mov rax, SYS_EXIT
	xor rdi, rdi		; status = 0
	syscall