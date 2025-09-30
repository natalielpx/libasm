; ===== FT_LIST_PUSH_FRONT =================================================================== ;
;  Function  : ft_list_push_front.s
;  Prototype : void	ft_list_push_front(t_list ** begin_list, void * data);
;  Purpose   : returns number of elements in linked list passed to it
;  Args      : rdi - address of address of beginning of list, rsi - address of data
;  Returns   : void
;  Clobbers  : rax
;  Arch      : x86-64 Linux (System V ABI)
; ============================================================================================ ;

default	rel
extern	malloc

; ===== Structure of expected address of list passed =====
; typedef struct s_list {
;     void          *data;
;     struct s_list *next;
; } t_list;

segment .text
global	ft_list_push_front

ft_list_push_front:

	; --- allocate memory for new element ---
	push qword rdi
	mov rdi, 16
	call malloc wrt ..plt
	pop rdi

	; --- check if malloc failed ---
	test rax, rax	; if malloc returned null
	jz .return		; return

	; --- rearrange registers ---
	mov rdx, rax
	mov rax, rdi
	mov rcx, [rdi]

	; --- fill new element ---
	mov [rdx], rsi
	mov [rdx + 8], rcx

	; --- set new element as begin ---
	mov [rax], rdx

.return:
	ret