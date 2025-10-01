; ===== FT_LIST_PUSH_FRONT =================================================================== ;
;  Function  : ft_list_push_front.s
;  Prototype : void	ft_list_push_front(t_list ** begin_list, void * data);
;  Purpose   : returns number of elements in linked list passed to it
;  Args      : rdi - address of address of beginning of list, rsi - address of data
;  Returns   : void
;  Arch      : x86-64 Linux (System V ABI)
; ============================================================================================ ;

%define	INT	dword

ENOMEM	equ 12

default	rel
extern	malloc
extern	__errno_location

; ===== Structure of expected address of list passed =====
; typedef struct s_list {
;     void          *data;
;     struct s_list *next;
; } t_list;

section .text
global	ft_list_push_front

ft_list_push_front:

; ===== CHECK =====

	; --- check if null ---
	; rdi = begin_list
	test rdi, rdi	; if !begin_list
	jz .return		; return

; ===== MEMORY ALLOCATION =====

	; --- allocate memory for new element ---
	push qword rdi	; save begin_list to stack
	push qword rsi	; save data to stack
	mov rdi, 16		; sizeof(t_list) = 16
	; void *malloc(size_t size);
	; rdi = sizeof(t_list) = 16
	call malloc wrt ..plt
	; rax = new (pointer to allocated memory)
	pop rsi			; rsi = data
	pop rdi			; rdi = begin_list

	; --- check if malloc failed ---
	test rax, rax	; if malloc returned null
	jz .error		; return

; ===== PUSH TO FRONT =====

	; --- save 1st element ---
	mov rdx, [rdi]	; rdx = 1st element (*begin_list)

	; --- set new element as begin ---
	mov [rdi], rax	; *begin_list = new
	
	; --- fill new element ---
	mov [rax], rsi		; new->data = data
	mov [rax + 8], rdx	; new->next = 1st element

; ===== RETURN =====

.return:
	; returns void
	ret

.error:
	; int * __errno_location(void)
    call __errno_location wrt ..plt
    mov [rax], INT ENOMEM	; *errno (4 bytes) = error number
	jmp .return