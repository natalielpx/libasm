; ===== FT_LIST_REMOVE_IF ==================================================================== ;
;  Function  : ft_list_remove_if.s
;  Prototype : void	ft_list_remove_if(t_list ** begin_list, void * data_ref, int (* cmp)(), void (* free_fct)(void *));
;  Purpose   : removes from list all elements where cmp(data, data_ref) returns 0
;  Args      : rdi - address of beginning of list, rsi - data reference, rdx - address of comparison function, rcx - freeing function
;  Returns   : void
;  Arch      : x86-64 Linux (System V ABI)
; ============================================================================================ ;

; ===== Structure of expected address of list passed =====
; typedef struct s_list {
;     void          *data;
;     struct s_list *next;
; } t_list;

%define PTR dword

section .text
global	ft_list_remove_if

ft_list_remove_if:

; ===== INITIALISATION =====

; --- check if null ---
	test rdi, rdi	; if begin_list == NULL
	je .return		; return
	test rsi, rsi	; if data_ref == NULL
	je .return		; return
	test rdx, rdx	; if comparison function missing
	je .return		; return
	test rcx, rcx	; if freeing function mission
	je .return		; return

; --- check lst size >= 1 ---
	cmp PTR [rdi], 0	; *begin_list = NULL
	je .return

; --- push callee saved registers ---
	push rbx
	push r12
	push r13
	push r14
	push r15

; --- save arguments ---
	mov rbx, rdi	; rbx = **begin_list
	xor r12, r12	; r12 = NULL (prev)
	mov r13, [rdi]	; r13 = *begin_list (current)
	mov r14, rsi	; r14 = data_ref
	mov r15, rdx	; r15 = int (* cmp)() (comparison function)
	push rcx		; push freeing function (less used)

; ===== COMPARISON =====

.compare:
; --- compare current element data against reference ---
	mov rdi, r14	; arg1 = data_ref
; !! if lst->data == NULL, [R13] will SEGFAULT !!
	cmp PTR r13, 0	; if lst->data == NULL
	je .next		; move on to next element
	mov rsi, [r13]	; arg2 = lst->data
	; int (* cmp)(data_ref, lst->data)
	; arg1 = rdi = data_ref
	; arg2 = rsi = lst->data
	call r15		; call int (* cmp)()
	; rax = difference
	cmp rax, 0		; if *(data_ref) == *(lst->data)
	je .remove		; remove element
; --- next ---
	mov r12, r13		; prev = current
	mov r13, [r13 + 8]	; current = current->next
	jmp .check_end		; check if end of list reached

; ===== REMOVAL =====

.remove:
; --- engineer my way around the lack of registers ---
	mov rdi, r13		; arg1 = current (element to free)
	mov r13, [r13 + 8]	; r13 = current->next = next
; --- check if head ---
	cmp r12, 0		; if prev != NULL
	jne .not_head	; 'connect' the two ends of the broken list
; --- update head ---
	mov [rbx], r13	; *begin_list = next
	jmp .free

.not_head:
; --- attach next to prev ---
	mov [r12 + 8], r13	; prev->next = next

.free:
; --- free removed element ---
	pop rbx		; pop freeing function into rbx (recycling no longer needed registers)
	; rdi = current
	; void (* free_fct)(void *)
	call rbx	; free(current)
	push rbx	; push freeing function back to stack

; ===== BASE CASE =====

.check_end:
; --- check if end ---
	cmp r13, 0		; if not end of list
	jne .compare	; repeat

; ===== RETURN =====

; --- pop freeing function ---
	pop rbx	
; --- restore callee saved registers ---
	pop r15
	pop r14
	pop r13
	pop r12
	pop rbx

.return:
; --- return void ---
	ret