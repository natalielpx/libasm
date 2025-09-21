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
	mov rax, 16
	call malloc wrt ..plt

	; --- check if malloc failed ---
	test	rax, rax	; if malloc returned null
	jz		.return		; return

	; --- fill new element ---
	mov [rax], rsi

	; --- save beginning of list ---
	push qword [rdi]

	; --- push new element to front ---
	mov [rdi], rax
	pop rdi
	mov [rax + 8], rdi

.return:
	ret