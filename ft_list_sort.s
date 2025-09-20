; ===== FT_LIST_SORT ========================================================================= ;
;  Function  : ft_list_sort.s
;  Prototype : void ft_list_sort(t_list ** begin_list, int (* cmp)());
;  Purpose   : sorts list according to passed comparison function
;  Args      : rdi - address of address of beginning of list, rsi - address of comparison function
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
global	ft_list_sort
extern	ft_strcmp

ft_list_sort:

; ===== INITIALISATION =====

	; --- push callee saved registers
	push rbx	; function
	push r12	; prev
	push r13	; current
	push r14	; next
	push r15	; **begin_list (head)

	; --- check list size >= 2 ---
	cmp qword [rdi], 0		; if *begin_list = null
	je .return				; return (nothing to sort)
	mov r12, [rdi]			; (unable to perform [[rdi] + 8])
	cmp qword [r12 + 8], 0	; if *begin_list->next = null
	je .return				; return (already sorted)

	; --- save arguments ---
	mov r15, rdi	; r15 = **begin_list ([r15] = head)
	mov rbx, rsi	; rbx = int (* cmp)()

; ===== BUBBLE SORT =====

.rerun:
; --- rerun comparisons throughout list ---
	mov r12, 0x00		; r12 = NULL (prev)
	mov r13, [r15]		; r13 = *begin_list (current)
	mov r14, [r13 + 8]	; r14 = *begin_list->next (next)
	xor rcx, rcx		; reset counter = 0

.compare:
; --- compare values of current->data & next->data ---
	mov rdi, [r13]	; arg1 = current->data
	mov rsi, [r14]	; arg2 = next->data
	call rbx		; call int (* cmp)()
	cmp rax, 0		; if return value <= 0
	jle .check_end	; advance without swapping

; --- if is beginning of list, update head ---
	cmp r12, 0x00	; if prev == NULL
	jne .not_head	; is not head
	mov [r15], r14	; head = next (b)
	jmp .swap

.not_head:
; --- update prev->next pointer ---
	mov [r12 + 8], r14	; prev->next = next (b)

.swap:
; --- rearrange pointers (swap a (current) & b (next)) ---
	mov rax, [r14 + 8]		; save next->next (b->next)
	mov [r14 + 8], r13		; b->next = a
	mov [r13 + 8], rax		; a->next = next->next
	mov r13, r14			; current = b

; --- increment counter
	inc	rcx	; ++counter

.check_end:
; --- check if end of list ---
	mov rax, [r14 + 8]		; save next->next
	cmp rax, 0				; if end of list
	je .check_sorted		; check if sorted

; --- move along list ---
	mov r12, r13		; prev = current
	mov r13, r14		; current = next
	mov r14, [r14 + 8]	; next = next->next
	jmp .compare

.check_sorted:		
	test rcx, rcx	; if counter != 0
	jnz .rerun		; rerun

; ===== RETURN =====

.return:
	; --- pop callee saved registers
	pop r15
	pop r14
	pop r13
	pop r12
	pop rbx
	; --- return ---
	ret