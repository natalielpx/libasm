; ===== HELLO ================================================================================ ;
;  Program : hello.asm
;  Purpose : Prints "Hello, world" to stdout
; ============================================================================================ ;
;  Architecture : x86-64
;  OS / ABI     : Linux
;  Assembler    : NASM syntax
;  Build        : nasm -f elf64 hello.asm -o hello.o
;  				  ld hello.o -o hello
;  Run          : ./hello
;  Exit         : 0 on success
; ============================================================================================ ;
;  Syscall   : rax = syscall number
;  Arguments : rdi, rsi, rdx, r10, r8, r9
;  Return    : rax
;  Remarks   : r10 is used because Linux syscalls overwrite rcx
; ============================================================================================ ;

; ----- System Call Numbers -----
SYS_WRITE   equ 1
SYS_EXIT    equ 60

; ----- File Descriptors --------
STD_OUT		equ 1

; ----- Memory Declarations -----
segment .data
	msg		db 'Hello, world', 0xa	; allocates message(msg) with trailing newline
	len		equ $-msg				; computes length(len) at assembly time

; ----- Instruction Code --------
segment .text
	global	_start

; ----- Entry Point -------------
_start:

	; -- write(STDOUT, msg, len) --
	mov rax, SYS_WRITE
	mov rdi, STD_OUT	; file descriptor
	mov rsi, msg		; buffer address
	mov rdx, len		; buffer length
	syscall

	; -- exit(EXIT_SUCCESS) --
	mov rax, SYS_EXIT
	xor rdi, rdi		; status = 0
	syscall