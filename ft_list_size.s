; ===== FT_LIST_SIZE ========================================================================= ;
;  Function  : ft_list_size.s
;  Prototype : int	ft_list_size(t_list * begin_list);
;  Purpose   : returns number of elements in linked list passed to it
;  Args      : rdi - address of beginning of list
;  Returns   : rax = length of list
;  Clobbers  : rax
;  Arch      : x86-64 Linux (System V ABI)
; ============================================================================================ ;

; ===== Structure of expected address of list passed =====
; typedef struct s_list {
;     void          *data;
;     struct s_list *next;
; } t_list;

segment .text
global	ft_list_size

ft_list_size:
	; --- initialise return value ---
	xor rax, rax	; return value: count = 0

.next:

	; --- check null ---
	test rdi, rdi	; check null pointer
	jz .return		; return

	; --- count element ---
	inc rax		; ++count

	; --- go to next element ---
	mov rdi, [rdi + 8]	; obtain address of lst->next
	jmp .next			; repeat

.return:
	ret