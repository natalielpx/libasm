; ===== FT_LIST_SORT ========================================================================= ;
;  Function  : ft_list_sort.s
;  Prototype : void ft_list_sort(t_list ** begin_list, int (* cmp)());
;  Purpose   : sorts list according to passed comparison function
;  Args      : rdi - address of address of beginning of list, rsi - address of comparison function
;  Returns   : void
;  Arch      : x86-64 Linux (System V ABI)
; ============================================================================================ ;

; ===== Structure of expected address of list passed =====
; typedef struct s_list {
;     void          *data;
;     struct s_list *next;
; } t_list;

%define PTR qword

default	rel
extern	malloc

section .text
global	ft_list_sort
extern	ft_strcmp

ft_list_sort:

; ===== INITIALISATION =====

; --- check if null ---
	; rdi = begin_list (t_list **)
	test rdi, rdi			; if begin_list == NULL
	je .return				; return
	; rsi = int (* cmp)()	; if comparison function missing
	test rsi, rsi			; return
	je .return

; --- check list size >= 2 ---
	cmp PTR [rdi], 0		; if *begin_list == null
	je .return				; return (size == 0 => nothing to sort)
	mov r12, [rdi]			; (unable to perform [[rdi] + 8])
	cmp PTR [r12 + 8], 0	; if *begin_list->next = null
	je .return				; return (size == 1 => already sorted)

; --- push callee saved registers
	push rbx	; function
	push r12	; prev
	push r13	; current
	push r14	; next
	push r15	; **begin_list (head)

; --- save arguments ---
	mov r15, rdi	; r15 = **begin_list ([r15] = head)
	mov rbx, rsi	; rbx = int (* cmp)()

; ===== BUBBLE SORT =====

.rerun:
; --- initialise prev, current, next, and counter ---
	xor r12, r12		; r12 = NULL (prev)
	mov r13, [r15]		; r13 = *begin_list (current)
	mov r14, [r13 + 8]	; r14 = *begin_list->next (next)
	xor rcx, rcx		; rcx = counter = 0

.compare:
; --- compare values of current->data & next->data ---
	; operations cannot be conducted between 2 memory values
	; memory in r13 (current->data) and r14 (next->data) are first stored in registers
	mov rdi, [r13]	; arg1 = *(current->data)
	mov rsi, [r14]	; arg2 = *(next->data)
	; int (* cmp)(*(current->data), *(next->data))
	; rdi = *(current->data)
	; rsi = *(next->data)
	call rbx		; call int (* cmp)()
	; rax = difference between both data
	cmp rax, 0		; if return value <= 0
	jle .check_end	; advance without swapping

; --- if is beginning of list, update head ---
	cmp r12, 0		; if prev == NULL
	jne .not_head	; is not head
	mov [r15], r14	; head = next (b_list)
	jmp .swap

.not_head:
; --- update prev->next pointer ---
	mov [r12 + 8], r14	; prev->next = next (b_list)

.swap:
; --- rearrange pointers (swap a_list (current) & b_list (next)) ---
	mov rax, [r14 + 8]		; save next->next (b_list->next)
	mov [r14 + 8], r13		; b_list->next = a_list
	mov [r13 + 8], rax		; a_list->next = next->next
	mov r13, r14			; current = b_list

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

; --- restore callee saved registers ---
	pop r15
	pop r14
	pop r13
	pop r12
	pop rbx

.return:
; --- return void ---
	ret