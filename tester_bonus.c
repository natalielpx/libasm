#include <stdio.h>
#include <string.h>
#include <unistd.h>
#include <stdlib.h>

#define STD_IN 0
#define STD_OUT 1
#define N 11

typedef struct s_list {
	void * data;
	struct s_list * next;
} t_list;

// libasm bonus functions
int 	ft_atoi_base(const char * str, int str_base);
void	ft_list_push_front(t_list ** begin_list, void * data);
int		ft_list_size(t_list * begin_list);
void	ft_list_sort(t_list ** begin_list, int (* cmp)());
void	ft_list_remove_if(t_list ** begin_list, void * data_ref, int (* cmp)(), void (* free_fct)(void *));

// helper functions
int		ft_strcmp(const char * s1, const char * s2);

int main(void) {
	
	printf("==========================\n");
    printf("===== LIBASM - BONUS =====\n");
    printf("==========================\n");
    

    printf("\n===== FT_ATOI_BASE =====\n");
    // prompts user for value
	char base[100];
    printf("Please enter a base (2-16): ");
    fgets(base, sizeof(base), stdin);
    char str[100];
    printf("Please enter a value: ");
    // reads line of text (spaces included)
    fgets(str, sizeof(str), stdin);

	printf("HAHAHA: %d\n", ft_atoi_base(str, atoi(base)));
    printf("========================\n");


	printf("\n===== FT_LIST_PUSH_FRONT =====\n");
	t_list ** lst = malloc(1);
	for (int i = 0; i < N; ++i) {
		char * data = malloc(sizeof(data));
		*data = i + 1 + '0';
		ft_list_push_front(lst, data);
		printf("pushed: %c\n", *data);
	}
    printf("==============================\n");


    printf("\n===== FT_LIST_SIZE =====\n");
	printf("list size: %d\n", ft_list_size(*lst));
    printf("========================\n");


	printf("\n===== FT_LIST_SORT =====\n");
	ft_list_sort(lst, ft_strcmp);
	for (t_list * tmp = *lst; tmp; tmp = tmp->next)
		printf("%s\n",tmp->data);
    printf("========================\n");


	printf("\n===== FT_LIST_REMOVE_IF =====\n");
	ft_list_remove_if(lst, ";", ft_strcmp, free);
	for (t_list * tmp = *lst; tmp; tmp = tmp->next)
		printf("%s\n",tmp->data);
    printf("=============================\n");

    return 0;
}