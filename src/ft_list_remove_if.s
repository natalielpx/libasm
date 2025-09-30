; ===== FT_LIST_REMOVE_IF ==================================================================== ;
;  Function  : ft_list_remove_if.s
;  Prototype : void	ft_list_remove_if(t_list ** begin_list, void * data_ref, int (* cmp)(), void (* free_fct)(void *));
;  Purpose   : removes from list all elements where cmp(data, data_ref) returns 0
;  Args      : rdi - address of beginning of list, rsi - data reference, rdx - address of comparison function, rcx - freeing function
;  Returns   : void
;  Clobbers  :
;  Arch      : x86-64 Linux (System V ABI)
; ============================================================================================ ;

; ===== Structure of expected address of list passed =====
; typedef struct s_list {
;     void          *data;
;     struct s_list *next;
; } t_list;

segment .text
global	ft_list_remove_if

ft_list_remove_if:

; ===== INITIALISATION =====

	; --- check lst size >= 1 ---
	cmp qword [rdi], 0	; *begin_list = NULL
	je .return

	; --- push callee saved registers
	push rbx	; **begin_list
	push r12	; prev
	push r13	; current
	push r14	; data_ref
	push r15	; comparison function

	; --- save arguments ---
	mov rbx, rdi	; rbx = **begin_list
	xor r12, r12	; r12 = NULL (prev)
	mov r13, [rdi]	; r13 = *begin_list (current)
	mov r14, rsi	; r14 = *data_ref
	mov r15, rdx	; r15 = int (* cmp)() (comparison function)
	push rcx		; push freeing function (less used)

.compare:
	; --- compare current element data against reference ---
	mov rdi, r14	; arg1 = *data_ref
	; PROBLEM HERE [R13] CAUSING SEGFAULT
	mov rsi, [r13]	; arg2 = lst->data
	call r15		; call int (* cmp)(*data_ref, lst->data)
	cmp rax, 0
	je .remove

	; --- next ---
	mov r12, r13		; prev = current
	mov r13, [r13 + 8]	; current = current->next
	jmp .check_end

.remove:
	; --- engineer my fucking way around the lack of registers ---
	mov rdi, r13		; arg1 = current (element to free)
	mov r13, [r13 + 8]	; r13 = next

	; --- if is head ---
	cmp r12, 0
	jne .not_head

	; --- update head ---
	mov [rbx], r13	; *begin_list = next
	jmp .free

.not_head:
	; --- attach next to prev ---
	mov [r12 + 8], r13	; prev->next = next

.free:
	pop rbx		; pop freeing function into rbx (no longer needed)
	call rbx	; free(current)
	push rbx	; push it back to stack

.check_end:
	; --- check end ---
	cmp r13, 0	; if reached end of list
	jne .compare

.return:
	; --- pop freeing function ---
	pop rbx	
	; --- restore callee saved registers ---
	pop r15
	pop r14
	pop r13
	pop r12
	pop rbx
	; --- return ---
	ret